import 'dart:async';

import 'package:firstapipro/core/constants/appconstants.dart';
import 'package:firstapipro/core/network/apiexception.dart';
import 'package:firstapipro/modules/view/registerstep3screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/snackbar.dart';

import '../../data/repositories/loginreposites.dart';
class Registerstep2viewmodel  extends GetxController{
  final Loginreposites repository=Loginreposites();
  final phonecontroller=TextEditingController();
  final otpcontroller=TextEditingController();
  final isloading = false.obs;
  final viewState = ViewState.initial.obs;
  final secondsLeft = 60.obs;
  Timer? timer;
  String name = '';
  String gender = '';
  String phone="";
   String  password="";
  bool get canResend => secondsLeft.value == 0;

  String get timerText {
    final min = (secondsLeft.value ~/ 60).toString().padLeft(2, '0');
    final sec = (secondsLeft.value % 60).toString().padLeft(2, '0');
    return '$min:$sec';
  }

  @override void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map && args['phone'] != null)
    { phonecontroller.text = args['phone'].toString();
    name = args['name']?.toString() ?? '';
    gender = args['gender']?.toString() ?? '';
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
    final phone=phonecontroller.text.trim();
    final otp=otpcontroller.text.trim();
    if (phone.isEmpty) {
      Snackbar.Showerror('Phone number is missing');
      return;
    }
    if(otp.isEmpty){
      Snackbar.Showerror("please enter you otp");
      return;
    }
    try{
      viewState.value = ViewState.loading;
      await repository.registerStep2(phone: phone,
          otp: otp);
      viewState.value=ViewState.success;
      Snackbar.ShowSuccess("otp verified success");
      // await Future.delayed( Duration(seconds: 3));
      Get.to(()=>Registerstep3screen(),
          arguments: {
          "phone":phonecontroller.text.trim(),
          }
          );


    }
    on ApiException catch(e){
      viewState.value=ViewState.error;
      Snackbar.Showerror(e.message);
    }


  }

  Future<void> resendOtp() async {
    if (!canResend) return;
    final phone = phonecontroller.text.trim();

    if (phone.isEmpty) {
      Snackbar.Showerror('Phone number is missing');
      return;
    }

    try {


      await repository.resendOtp(phone:phone,
        name: name,
        gender: gender,);
      startTimer();
      Snackbar.ShowSuccess('OTP resent successfully');
    } on ApiException catch (e) {
      // viewState.value = ViewState.error;
      Snackbar.Showerror(e.message);
    }
  }
  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }


}