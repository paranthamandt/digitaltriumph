import 'package:firstapipro/modules/viewmodel/forgetnewpasswordviewmodel.dart';
import 'package:flutter/material.dart';

import '../../core/theme/appcolor.dart';
import '../../core/theme/textstyle.dart';
import '../../core/utils/validation.dart';
import '../../shared/widgets/elevatebutton.dart';
import '../../shared/widgets/textfields.dart';
import 'package:get/get.dart';
class Forgetnewpasswordscreen extends StatelessWidget {
   Forgetnewpasswordscreen({super.key});
   final Forgetnewpasswordviewmodel controller= Get.put(Forgetnewpasswordviewmodel()) ;
  final fromKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundColor1,
 body: Form(
   key: fromKey,
   child: Column(
     children: [SizedBox(height: 50,),
       Row(
         children: [
         IconButton(onPressed: (){
           Get.back();
         },
             icon: Icon(Icons.arrow_back))
       ],),
       Padding(
         padding: const EdgeInsets.all(15.0),
         child: Row(
           children: [
             Text("New Password",style: Textstyle.body,),
           ],
         ),
       ),
       Textfields(
         controller: controller.passwordcontroller,
         hintText: "enter you password",
         validator: Validation. password,
         prefixIcon: Icon(Icons.password),
         isPassword: true,
       ),
       Padding(
         padding: const EdgeInsets.all(15.0),
         child: Row(
           children: [
             Text("ConfirmPassword",style: Textstyle.body,),
           ],
         ),
       ),
       Textfields(
         controller: controller.confirmpasswordcontroller,
         hintText: "enter you confirm password",
          validator: (value) {
    if (value != controller.passwordcontroller.text) {
    return "Passwords do not match";
    }
    return Validation.password(value);
    },

         prefixIcon: Icon(Icons.lock),
         isPassword: true,
       ),
       SizedBox(height: 30,),

       Obx(
             () => controller.isloading.value
             ? const Center(child: CircularProgressIndicator())
             : Elevatebutton(
           height: 45,
           width: double.infinity,
           onPressed: () {
             if (fromKey.currentState!.validate()) {
               controller.resetPassword();
             }
           },
           text: "verify",
         ),
       ),
     ],
   ),
 ),
    );
  }
}
