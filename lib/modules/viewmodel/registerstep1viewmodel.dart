import 'package:firstapipro/core/network/apiexception.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/constants/appconstants.dart';
import '../../core/utils/snackbar.dart';
import '../../data/repositories/loginreposites.dart';
import '../view/registerstep2screen.dart';
class Registerstep1viewmodel extends GetxController{
  final Loginreposites repository=Loginreposites();
  final phonecontroller=TextEditingController();
  final namecontroller=TextEditingController();
  final otpcontroller=TextEditingController();
  // final gendercontroller=TextEditingController();
  final isloading=false.obs;
  final isotpsend=false.obs;
  final viewState = ViewState.initial.obs;
  final isOtpSent = false.obs;
  final selectedGender = Rxn<String>();
  final genders =  ['Male', 'Female', 'Other'];
  final isPhoneLocked = false.obs;
  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map && args['phone'] != null) {
      phonecontroller.text = args['phone'].toString();
      isPhoneLocked.value = true;
    } else {
      isPhoneLocked.value = false;
    }
  }


  Future<void> requestMobileOtp() async {
    if (viewState.value == ViewState.loading)
      return;
    if (namecontroller.text.trim().isEmpty)
  { Snackbar.Showerror('Please enter your name');
    return;
  }
    if (phonecontroller.text.trim().length < 10) {
      Snackbar.Showerror('Please enter a valid 10-digit phone number');
      return;
    }
    if (selectedGender.value==null) {
      Snackbar.Showerror("Please Select gender");
      return;
    }

    try {
      viewState.value = ViewState.loading;
      final response = await repository.registerStep1(
      name: namecontroller.text.trim(),
      phone: phonecontroller.text.trim(),
      gender: selectedGender.value,
      clinicalRole: "customer"
      );

      final data = response["data"];
      final otp = response["phoneOtp"] ??
          response["otp"] ??
          (data is Map ? (data["phoneOtp"] ?? data["otp"]) : null);
      if (otp != null) otpcontroller.text = otp.toString();


      Snackbar.ShowSuccess('OTP sent successfully');
      viewState.value = ViewState.success;


          Get.to(()=>Registerstep2screen(),
              arguments: {
                "phone":phonecontroller.text.trim(),
                "name": namecontroller.text.trim(),
                "gender": selectedGender.value,
              }

      );
    } on ApiException catch (e) {
      viewState.value = ViewState.error;
      Snackbar.Showerror(e.message);


    }

  }


}

