import 'package:firstapipro/core/constants/appconstants.dart';
import 'package:firstapipro/core/utils/validation.dart';
import 'package:firstapipro/modules/viewmodel/mobileloginviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/theme/appcolor.dart';
import '../../core/theme/textstyle.dart';
import '../../core/values/assets.dart';
import '../../shared/widgets/BlueBackground.dart';
import '../../shared/widgets/elevatebutton.dart';
import '../../shared/widgets/textfields.dart';
class Mobileloginscreen extends StatelessWidget {
   Mobileloginscreen({super.key});
   Mobileloginviewmodel controller= Get.put(Mobileloginviewmodel());
   final fromKey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Appcolor.backgroundColor1,
      body: Form(
        key: fromKey,
        child:
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
              children: [SizedBox(height: 40,),
                Row(
                  children: [
                    IconButton(onPressed: (){
                      Get.back();
                    },
                        icon: Icon(Icons.arrow_back)),
                  ],
                ),
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration:  BoxDecoration(),
                  child: Image.asset(
                    Assets.logo1,
                    fit: BoxFit.contain,
                  ),
                ),
              SizedBox(height: 30,),
                Text(" otp verification for mobile ",style: Textstyle.title,),
                // SizedBox(height: 50,),
                Textfields(
                  controller: controller.Phonecontroller,
                  prefixText: "91  ",
                  hintText: "enter the phone number",
                  validator: Validation.phone,
                  prefixIcon: Icon(Icons.call),
                  keyboardType: TextInputType.phone,
                  // maxLength: 10,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10)
                  ],

                ),
                SizedBox(height: 25,),
                Elevatebutton(
                  height: 45,
                  width: double.infinity,
                  onPressed: (){
                    controller.islogging.value;
                    if(fromKey.currentState!.validate()){
                      controller.mobilelogin();
                    }
                  },
                     text: "Get OTP",
                )
              ],
                       ),
           ),
        ),

    );
  }
}
