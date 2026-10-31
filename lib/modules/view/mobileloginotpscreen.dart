import 'package:firstapipro/core/utils/validation.dart';
import 'package:firstapipro/data/models/mobileloginotpmodel.dart';
import 'package:firstapipro/modules/viewmodel/mobileloginotpviewmodel.dart';
import 'package:firstapipro/modules/viewmodel/mobileloginviewmodel.dart';
import 'package:firstapipro/shared/widgets/otpwigtes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/appcolor.dart';
import '../../core/theme/textstyle.dart';
import '../../shared/widgets/elevatebutton.dart';
import '../../shared/widgets/textbutton.dart';
import '../../shared/widgets/textfields.dart';
class  Mobileloginotpscreen extends StatelessWidget {
   Mobileloginotpscreen({super.key});
   final Mobileloginotpviewmodel controller=Get.put(Mobileloginotpviewmodel());

final fromKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Appcolor.backgroundColor1,
      body:
          Form(
            key: fromKey,
            child: Column(
              children: [SizedBox(height: 50,),
                Row(children: [
                  IconButton(onPressed: (){
                    Get.back();
                  },
                      icon: Icon(Icons.arrow_back))
                ],),
                Text("Otp Verification",style: Textstyle.heading,),
                SizedBox(height: 20,),
                Text("Enter the verification code we have send to " ,style: Textstyle.body,),
                SizedBox(height: 30,),
                Text(
                  "+91 ${controller.phonecontroller.text},",style:Textstyle.body ,
                ),
                Otpwigtes(
                  length: 6,
                  controller: controller.otpcontroller,
                  validator: Validation.otp,
                ),
                SizedBox(height: 30,),
                Elevatebutton (onPressed: (){
                  controller.isloading.value;
                  if(fromKey.currentState!.validate()){
                    controller.Mobileotp(
                      phone: controller.phonecontroller.text.trim(),
                      otp: controller.otpcontroller.text.trim()
                    );
                  }

                },
                 text:"Verify",
                height: 50,
                  width: double.infinity,
                ),
                Obx(() => Column(
                  children: [
                    if (!controller.canResend)
                      Text(
                        "You may resend OTP in ${controller.timerText} min",
                        style: Textstyle.body,
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't receive OTP?",
                            style: Textstyle.body),
                        Textbutton(
                          text: "Resend OTP",
                          onPress: controller.canResend
                              ? controller.resendOtp
                              : () {},
                        ),
                      ],
                    ),
                  ],
                )),

              ],
            ),
                   ),
         );
  }
}
