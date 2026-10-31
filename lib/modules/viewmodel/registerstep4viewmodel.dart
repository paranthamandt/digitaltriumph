import 'dart:async';

import 'package:firstapipro/modules/view/homescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/appconstants.dart';
import '../../core/network/apiexception.dart';
import '../../core/storageservices/serviceskey.dart';
import '../../core/utils/snackbar.dart';
import '../../data/repositories/loginreposites.dart';
import '../view/loginscreen.dart';
class Registerstep4viewmodel extends GetxController{
  final Loginreposites repository=Loginreposites();
  final emailcontroller=TextEditingController();
  final otpcontroller=TextEditingController();
  final isloading = false.obs;
  final viewState = ViewState.initial.obs;
  final secondsLeft = 60.obs;
  Timer? timer;
  String phone = '';
  String password = '';
  bool get canResend => secondsLeft.value == 0;

  String get timerText {
    final min = (secondsLeft.value ~/ 60).toString().padLeft(2, '0');
    final sec = (secondsLeft.value % 60).toString().padLeft(2, '0');
    return '$min:$sec';
  }

  @override void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map && args["email"] != null) {
      emailcontroller.text = args['email']?.toString() ?? '';
      phone = args['phone']?.toString() ?? '';
      password = args['password']?.toString() ?? '';
    }
    startTimer();
  }
  void startTimer() {
    timer?.cancel();
    secondsLeft.value = 60;
    timer = Timer.periodic( Duration(seconds: 1), (time) {
      if (secondsLeft.value > 0) {
        secondsLeft.value--;
      } else {
        time.cancel();
      }
    });
  }

  Future<void>verifyotp()async{
    final email=emailcontroller.text.trim();
    final otp=otpcontroller.text.trim();
    if (email.isEmpty) {
      Snackbar.Showerror('email  is missing');
      return;
    }
    if(otp.isEmpty){
      Snackbar.Showerror("please enter you otp");
      return;
    }
    try{
      viewState.value = ViewState.loading;
      final response= await repository.registerStep4(email:email,
          otp: otp);

      final data = response['data'];
      await Serviceskey.userBox.put('accessToken', data['accessToken']);
      await Serviceskey.userBox.put('refreshToken', data['refreshToken']);
      await Serviceskey.userBox.put('customerData', data['customer']);

      viewState.value=ViewState.success;
      Snackbar.ShowSuccess("otp verified success");
      Get.offAll(()=>Homescreen());


    }
    on ApiException catch(e){
      viewState.value=ViewState.error;
      Snackbar.Showerror(e.message);
    }
  }

  Future<void> resendOtp() async {
    if (!canResend) return;
    try {
      await repository.registerStep3(
        phone: phone,
        email: emailcontroller.text.trim(),
        password: password,
      );
      startTimer();
      Snackbar.ShowSuccess('OTP resent successfully');
    } on ApiException catch (e) {
      Snackbar.Showerror(e.message);
    }
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

}