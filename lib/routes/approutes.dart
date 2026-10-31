
import 'package:firstapipro/modules/view/Editscreen.dart';
import 'package:firstapipro/modules/view/forgetnewpasswordscreen.dart';
import 'package:firstapipro/modules/view/forgetpasswordotp%20screen.dart';
import 'package:firstapipro/modules/view/forgetpasswordscreen.dart';
import 'package:firstapipro/modules/view/mobileloginotpscreen.dart';
import 'package:firstapipro/modules/view/mobileloginscreen.dart';
import 'package:firstapipro/modules/view/productdetailsscreen.dart';
import 'package:firstapipro/modules/view/registerstep3screen.dart';
import 'package:firstapipro/modules/view/searchscreen.dart';
import 'package:get/get.dart';

import '../modules/view/homescreen.dart';
import '../modules/view/loginscreen.dart';
import 'package:firstapipro/routes/apppage.dart';
import '../modules/view/forgetpasswordscreen.dart';
import '../modules/view/profilescreen.dart';
import '../modules/view/registerstep1screen.dart';
import '../modules/view/registerstep2screen.dart';
import '../modules/view/registerstep4screen.dart';
import 'package:firstapipro/modules/view/splashscreen.dart';
import '../modules/view/mobileloginscreen.dart';
 class Approutes {
   static final page=[
  GetPage(
name:Apppage.login,
page:()=>Loginscreen()
),

     GetPage(
         name:Apppage.registerstep1,
         page:()=>Registerstep1screen(),transition: Transition.leftToRight
     ),


     GetPage(
         name:Apppage.registerstep2,
         page:()=>Registerstep2screen(),transition: Transition.rightToLeft

     ),
     GetPage(
         name:Apppage.registerstep3,
         page:()=>Registerstep3screen(),transition: Transition.upToDown
     ),
     GetPage(
         name:Apppage.registerstep4,
         page:()=>Registerstep4screen(),transition: Transition.downToUp
     ),
     GetPage(name: Apppage.home,
         page: ()=>Homescreen(),transition: Transition.rightToLeft),
     GetPage(name: Apppage.splashscreen,
         page: ()=>Splashscreen(),transition: Transition.leftToRight),
     GetPage(name: Apppage.Mobileloginscreen,
         page: ()=>Mobileloginscreen(),transition: Transition.rightToLeft),
     GetPage(name: Apppage.Mobileloginotpscreen,
         page: ()=>Mobileloginotpscreen(),transition: Transition.downToUp),

     GetPage(name: Apppage.Profilescreen,
         page: ()=>Profilescreen(),transition: Transition.leftToRight),

     GetPage(name: Apppage.Editscreen,
         page: ()=>Editscreen(),transition: Transition.rightToLeft),
      GetPage(name: Apppage.Forgotpassword,
          page: ()=>Forgetpasswordscreen(),transition: Transition.rightToLeft),
     GetPage(name: Apppage.Forgototp,
         page: ()=>Forgetpasswordotpscreen(),transition: Transition.rightToLeft),


     GetPage(name: Apppage.Forgotnewpassword,
         page: ()=>Forgetnewpasswordscreen(),transition: Transition.rightToLeft),


     GetPage(name: Apppage.Productdetailsscreen,
         page: ()=>Productdetailsscreen(productId:Get.arguments as String),transition: Transition.rightToLeft),


     GetPage(name: Apppage.Searchscreen,
         page: ()=>Searchscreen(),transition: Transition.rightToLeft),


   ];

 }
