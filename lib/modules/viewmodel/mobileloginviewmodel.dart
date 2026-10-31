import 'package:firstapipro/data/repositories/loginreposites.dart';
import 'package:firstapipro/modules/view/mobileloginotpscreen.dart';
import 'package:firstapipro/routes/apppage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/constants/appconstants.dart';
import '../../core/network/apiexception.dart';
import '../../core/utils/snackbar.dart';
class Mobileloginviewmodel extends GetxController{
  final Loginreposites repository =Loginreposites();
  final Phonecontroller=TextEditingController();
  final otpcontroller=TextEditingController();
  final islogging=false.obs;
  final viewState = ViewState.initial.obs;
  @override
  void onClose(){
    Phonecontroller.dispose();
    otpcontroller.dispose();
    super.onClose();
  }

  Future<dynamic>mobilelogin()async{
    if(viewState .value==ViewState.loading)
      return;
    if(Phonecontroller.text.trim().length<10){
      Snackbar.Showerror("please enter valid 10 dities phone number");
          return;
    }
    try {
      islogging.value =true;
      final response = await repository.Mobilelogin(
          phone: Phonecontroller.text.trim());


      final otp = response["phoneOtp"];

      if (otp != null) otpcontroller.text = otp.toString();


      Snackbar.ShowSuccess('OTP sent successfully');

      // await Future.delayed( Duration(seconds:3));

      Get.toNamed(Apppage.Mobileloginotpscreen,
          arguments: {
            "phone":Phonecontroller.text.trim(),
          }

      );
    } on ApiException catch (e) {
      Snackbar.Showerror(e.message);


    }
  }
}