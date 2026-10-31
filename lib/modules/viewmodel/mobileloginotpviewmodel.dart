import 'dart:async';

import 'package:firstapipro/core/constants/appconstants.dart';
import 'package:firstapipro/data/repositories/loginreposites.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/network/apiexception.dart';
import '../../core/storageservices/serviceskey.dart';
import '../../core/utils/snackbar.dart';
import '../view/homescreen.dart';
import '../view/registerstep1screen.dart';
class Mobileloginotpviewmodel  extends GetxController {
  final Loginreposites repository = Loginreposites();
  final phonecontroller = TextEditingController();
  final otpcontroller = TextEditingController();
  final isloading = false.obs;
  final viewstatus = ViewState.initial.obs;

  final secondsLeft = 60.obs;
  Timer? timer;

  bool get canResend => secondsLeft.value == 0;

  String get timerText {
    final min = (secondsLeft.value ~/ 60).toString().padLeft(2, '0');
    final sec = (secondsLeft.value % 60).toString().padLeft(2, '0');
    return '$min:$sec';
  }


  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map && args["phone"] != null) {
      phonecontroller.text = args["phone"].toString();
    }
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    secondsLeft.value = 60;
    timer = Timer.periodic(Duration(seconds: 1), (time) {
      if (secondsLeft.value > 0) {
        secondsLeft.value--;
      } else {
        time.cancel();
      }
    });
  }

  Future<void> Mobileotp({required String phone, required String otp}) async {
    if (isloading.value) return;
    isloading.value = true;
    try {
      final response = await repository.Mobileotplogin(phone: phone, otp: otp);

      if (response.newCustomer ||
          response.status != 'Active' ||
          !response.isEmailVerified) {
        Snackbar.Showerror("Please complete your registration");
        Get.offAll(() => Registerstep1screen(), arguments: {"phone": phone});
        return;
      }
      final accessToken = response.accessToken;
      final refreshToken = response.refreshToken;
      if (accessToken == null || refreshToken == null) {
        Snackbar.Showerror("Login error");
        return;
      }

      await Serviceskey.saveLogin(
        accessToken: accessToken,
        refreshToken: refreshToken,
        customer: response.customer,
      );
      Snackbar.ShowSuccess("Login Successfully");
      Get.offAll(() => Homescreen());
    } on ApiException catch (e) {
      Snackbar.Showerror(e.message);
    } catch (e) {
      Snackbar.Showerror("Something went wrong: $e");
    } finally {
      isloading.value = false;
    }}


    Future<void> resendOtp() async {
      if (!canResend) return;
      final phone = phonecontroller.text.trim();
      if (phone.isEmpty) {
        Snackbar.Showerror('Phone number is missing');
        return;
      }
      try {
        await repository.Mobilelogin(phone: phone);
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




