import 'package:firstapipro/modules/view/registerstep2screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/theme/appcolor.dart';
import '../../core/theme/textstyle.dart';
import '../../core/utils/validation.dart';
import '../../core/values/assets.dart';
import '../../shared/widgets/dropdownbutton.dart';
import '../../shared/widgets/elevatebutton.dart';
import '../../shared/widgets/textfields.dart';
import '../viewmodel/registerstep1viewmodel.dart';
class Registerstep1screen extends StatelessWidget {
   Registerstep1screen({super.key});

  final Registerstep1viewmodel controller =Get.put(Registerstep1viewmodel());
   final fromKey=GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Appcolor.backgroundColor1,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: fromKey,
          // child:Obx(()=>
         child:  Column(
            children: [
              SizedBox(height: 40,),
              Row(
                children: [
                  IconButton(onPressed: (){
                    Get.back();
                  },
                      icon: Icon(Icons.arrow_back)),
                ],
              ),
              Container(
                height: 200,
                width: double.infinity,
                decoration:  BoxDecoration(),
                child: Image.asset(
                  Assets.logo1,
                  fit: BoxFit.contain,
                ),
              ),
              Text("Signup",style:  Textstyle.heading),
              if (!controller.isotpsend.value)
                // SizedBox(height: 50,),
                Row(
                  children: [
                    Text("Name",style: Textstyle.title,),
                  ],
                ),
              Textfields(

                controller: controller.namecontroller,
                hintText: "enter you name",
                validator: Validation.name,

              ),
              // SizedBox(height: 40,),
              Row(children: [
                Text("Phone ",style:Textstyle.title ,)
              ],),
              Textfields(
                controller: controller.phonecontroller,
                hintText: " 123-456-7890",
                prefixText: "91  ",
                readOnly: controller.isPhoneLocked.value,
                validator: Validation.phone,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10)
                ],

              ),
      Row(
      children: [
        Text("Selected Gender",style: Textstyle.title,),
      ],
    ),
    Dropdownbutton(
    hintText: 'Select Gender',
    items: controller.genders,
    value: controller.selectedGender.value,
    onChanged: (value) {
    controller.selectedGender.value = value;
    },),

              // SizedBox(height: 40,),
              Elevatebutton(
                text: "send Otp",
                height: 50,
                width: double.infinity,
                onPressed: (){
                  controller.isloading.value;
                  if(fromKey.currentState!.validate()){
                    controller.requestMobileOtp();


                  }
                },
              ),




          ]
          ),
        // ),
        ),
      )
    );
  }
}