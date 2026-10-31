import 'package:firstapipro/modules/view/homescreen.dart';
import 'package:firstapipro/modules/view/loginscreen.dart';
import 'package:firstapipro/modules/view/mobileloginscreen.dart';
import 'package:firstapipro/routes/apppage.dart';
import 'package:get/get.dart';

import '../../core/storageservices/serviceskey.dart';
class Splashscreenviewmodel extends GetxController{
  @override
  void onInit() {
    super.onInit();
    checklogin();
  }

  Future<void> checklogin()async{
    await Future.delayed(Duration(seconds: 4));
    if(Serviceskey.isLoggedIn){
      Get.offAll(()=>Homescreen());
    }
    else{
      Get.offAll(()=>Loginscreen());
    }
  }
}