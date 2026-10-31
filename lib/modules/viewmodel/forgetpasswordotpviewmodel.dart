import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/network/apiexception.dart';
import '../../core/utils/snackbar.dart';
import '../../data/repositories/loginreposites.dart';
import '../../routes/apppage.dart';

class Forgetpasswordotpviewmodel extends GetxController {
  final Loginreposites repository = Loginreposites();
  final emailcontroller = TextEditingController();
  final otpcontroller = TextEditingController();
  final isloading = false.obs;
  final isResending = false.obs;

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
    if (args is Map && args["email"] != null) {
      emailcontroller.text = args["email"].toString();
    }
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    secondsLeft.value = 60;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsLeft.value > 0) {
        secondsLeft.value--;
      } else {
        t.cancel();
      }
    });
  }

  void forgetotp() async {
    if (isloading.value) return;
    isloading.value = true;
    // try {
    //   final message = await repository.for(
    //     emailcontroller.text.trim(),
    //     otpcontroller.text.trim(),
    //   );
    //   Snackbar.ShowSuccess(message);
      Get.toNamed(Apppage.Forgotnewpassword, arguments: {
        "email": emailcontroller.text.trim(),
        "otp": otpcontroller.text.trim(),
      });
  //   } on ApiException catch (e) {
  //     Snackbar.Showerror(e.message);
  //   } catch (e) {
  //     Snackbar.Showerror("something is wrong:$e");
  //   } finally {
  //     isloading.value = false;
  //   }
  }

  Future<void> resendOtp() async {
    if (!canResend || isResending.value) return;
    isResending.value = true;
    try {
      final message =
      await repository.forgotresendpasswordotp(emailcontroller.text.trim(),);
      Snackbar.ShowSuccess(message);
      otpcontroller.clear();
      startTimer();
    } on ApiException catch (e) {
      Snackbar.Showerror(e.message);
    } catch (e) {
      Snackbar.Showerror("something is wrong:$e");
    } finally {
      isResending.value = false;
    }
  }

  @override
  void onClose() {
    timer?.cancel();
    emailcontroller.dispose();
    otpcontroller.dispose();
    super.onClose();
  }
}