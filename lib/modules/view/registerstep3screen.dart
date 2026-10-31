import 'package:firstapipro/core/utils/validation.dart';
import 'package:firstapipro/modules/viewmodel/registerstep3viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/appcolor.dart';
import '../../core/theme/textstyle.dart';
import '../../shared/widgets/elevatebutton.dart';
import '../../shared/widgets/textfields.dart';
import 'package:get/get.dart';
class Registerstep3screen extends StatelessWidget {
   Registerstep3screen({super.key});
  final Registerstep3viewmodel controller=Get.put(Registerstep3viewmodel());

   final fromKey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Appcolor.backgroundColor1,
      body:SingleChildScrollView(
        child: Form(
          key: fromKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [SizedBox(height: 40,),
                  Row(children: [
                    IconButton(onPressed: (){
                      Get.back();
                    },
                        icon: Icon(Icons.arrow_back))
                  ],),
                  Text("Create Account",style: Textstyle.heading,),
                  SizedBox(height: 30,),


                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Text("Email",style: Textstyle.body,),
                    ],
                  ),
                  Textfields(
                    controller: controller.emailcontroller,
                    hintText: "enter you email",
                    validator: Validation.email,
                    prefixIcon: Icon(Icons.email),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Text("Password",style: Textstyle.body,),
                    ],
                  ),
                  Textfields(
                    controller: controller.passwordcontroller,
                    hintText: "enter you password",
                    validator: Validation.password,
                    prefixIcon: Icon(Icons.password),
                    isPassword: true,
                  ),
                  Row(
                    children: [
                      Text("ConfirmPassword",style: Textstyle.body,),
                    ],
                  ),
                  Textfields(
                    controller: controller.confirmpasswordcontroller,
                    hintText: "enter you confirm password",
                    validator: Validation.password,
                    prefixIcon: Icon(Icons.lock),
                    isPassword: true,
                  ),
                  SizedBox(height: 30,),

                  Elevatebutton(
                    height: 45,
                    width: double.infinity,
                    onPressed: (){
                      controller.isloading.value;
                      if(fromKey.currentState!.validate()){
                        controller.registerstep3();
                      }
                    },
                    text: "Get email otp",
                  )


                ],
              ),
            ),
          ),
      ),
     
    );
  }
}
