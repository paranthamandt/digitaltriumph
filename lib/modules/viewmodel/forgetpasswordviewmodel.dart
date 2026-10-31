import 'package:firstapipro/core/network/apiexception.dart';
import 'package:firstapipro/core/utils/snackbar.dart';
import 'package:firstapipro/data/repositories/loginreposites.dart';
import 'package:firstapipro/routes/apppage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class Forgetpasswordviewmodel  extends GetxController{
  final Loginreposites reposites=Loginreposites();
  final emailcontroller=TextEditingController();
  final isloading=false.obs;
  final  formKey= GlobalKey<FormState>();
  final isEmailLocked = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map && args["email"] != null &&
        args["email"].toString().isNotEmpty) {
      emailcontroller.text = args["email"].toString();
      isEmailLocked.value = true;
    }
  }

  Future<void>forpassword()async{
    if(!formKey.currentState!.validate())
      return;
    if(isloading.value)return;
    isloading.value=true;
    try{
      final message=await reposites.forgotpassword(emailcontroller.text.trim());
      Snackbar.ShowSuccess(message);
      Get.toNamed(Apppage.Forgototp,arguments: {
        "email":emailcontroller.text.trim()
      }
      );
    }
    on ApiException catch(e){
      Snackbar.Showerror( e.message);
    }
    // catch (e){
    //   Snackbar.Showerror("something is wrong:$e");
    // }
    finally{
      isloading.value=false;
    }
  }
}