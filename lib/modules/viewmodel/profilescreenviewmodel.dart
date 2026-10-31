import 'package:get/get.dart';

import '../../core/storageservices/serviceskey.dart';
import '../view/loginscreen.dart';
class Profilescreenviewmodel  extends GetxController{
  var username="".obs;
  var useremail="".obs;
  @override
  void onInit() {
    super.onInit();
    final Customer=Serviceskey.customer;
    username.value=Customer?["name"]?.toString()??"";
    useremail.value=Customer?["email"]?.toString()??"";

  }
  Future<void>logout()async{
    await Serviceskey.clear();
    Get.offAll(()=>Loginscreen());
  }
}