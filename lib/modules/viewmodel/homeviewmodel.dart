import 'package:firstapipro/core/storageservices/serviceskey.dart';
import 'package:firstapipro/modules/view/loginscreen.dart';
import 'package:firstapipro/modules/view/mobileloginscreen.dart';
import 'package:get/get.dart';

import '../view/profilescreen.dart';
class Homeviewmodel  extends GetxController{
// var username="".obs;
// var useremail="".obs;
var seletedIndex=0.obs;
void changeTab(int index) {

  seletedIndex.value = index;
}

}