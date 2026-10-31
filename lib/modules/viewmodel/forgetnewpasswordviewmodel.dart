import 'package:firstapipro/core/network/apiexception.dart';
import 'package:firstapipro/routes/apppage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../core/utils/snackbar.dart';
import '../../data/repositories/loginreposites.dart';
class Forgetnewpasswordviewmodel extends GetxController{

  final Loginreposites repository = Loginreposites();
  final emailcontroller = TextEditingController();
  final otpcontroller = TextEditingController();
  final isloading = false.obs;
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();



  late final String email;
  late final String otp;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    email = args['email'] ?? '';
    otp = args['otp'] ?? '';
  }

  Future<void> resetPassword() async {
    if (passwordcontroller.text != confirmpasswordcontroller.text) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }
    try {
      isloading.value = true;
      final message = await repository.resetPassword(
        email: email,
        otp: otp,
        password: passwordcontroller.text.trim(),
      );
      Snackbar.ShowSuccess(message);
      Get.offAllNamed(Apppage.login);
    } on ApiException catch (e) {
      Snackbar.Showerror( e.message);
    } catch (e) {
      Snackbar.Showerror(e.toString());
    } finally {
      isloading.value = false;
    }
  }



  @override
  void onClose() {
    passwordcontroller.dispose();
    confirmpasswordcontroller.dispose();
    super.onClose();
  }
}


