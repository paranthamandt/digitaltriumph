import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/constants/appconstants.dart';
import '../../core/network/apiexception.dart';
import '../../core/utils/snackbar.dart';
import '../../data/repositories/loginreposites.dart';
import '../view/registerstep4screen.dart';
class Registerstep3viewmodel extends GetxController {
  final Loginreposites repository=Loginreposites();
  final phonecontroller=TextEditingController();
  final emailcontroller=TextEditingController();
  final passwordcontroller=TextEditingController();
  final confirmpasswordcontroller=TextEditingController();
  final isloading = false.obs;
  final viewState = ViewState.initial.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    phonecontroller.text = Get.arguments['phone'] ?? '';
  }
  @override
  void onClose(){
    phonecontroller.dispose();
    super.onClose();
  }


  Future<void>registerstep3()async{
    final  phone=phonecontroller.text.trim();
    final email=emailcontroller.text.trim();
    final password=passwordcontroller.text.trim();
    final confirmpassword=confirmpasswordcontroller.text.trim();
    // if (phone.isEmpty) {
    //   Snackbar.Showerror('Phone number is missing');
    //   return;
    // }
    if (email.isEmpty) {
      Snackbar.Showerror('email  is missing');
      return;
    }
    if (password.isEmpty) {
      Snackbar.Showerror('password is missing');
      return;
    }
    if (confirmpassword.isEmpty) {
      Snackbar.Showerror('password is missing');
      return;
    }
    if ( password!=confirmpassword) {
      Snackbar.Showerror('password does not match');
      return;
    }
    try {
      isloading.value=true;
      await repository.registerStep3(
          phone: phone,
          email: email,
          password: password);
      viewState.value=ViewState.success;
      Snackbar.ShowSuccess("otp send success");
      // await Future.delayed( Duration(seconds: 3));
      Get.to(()=>Registerstep4screen(),
      arguments: {
        // "email":emailcontroller.text.trim(),
        "phone": phone,
        "email": email,
        "password": password,});

    }
    on ApiException catch(e){
      viewState.value=ViewState.error;
      Snackbar.Showerror(e.message);
    }

  }
  // @override
  // void onClose() {
  //   passwordcontroller.dispose();
  //   emailcontroller.dispose();
  //   passwordcontroller.dispose();
  //   super.onClose();
  // }

}