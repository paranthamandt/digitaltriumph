import 'package:firstapipro/modules/viewmodel/forgetpasswordviewmodel.dart';
import 'package:firstapipro/shared/widgets/appbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/appcolor.dart';
import '../../core/theme/textstyle.dart';
import '../../core/utils/validation.dart';
import '../../shared/widgets/elevatebutton.dart';
import '../../shared/widgets/textfields.dart';

class Forgetpasswordscreen extends StatelessWidget {
   Forgetpasswordscreen({super.key});
final Forgetpasswordviewmodel controller=Get.put(Forgetpasswordviewmodel());
   // final fromKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Appcolor.backgroundColor1,
      body: Form(
        key: controller.formKey,
        child: Column(
          children: [SizedBox(height: 40,),
            Row(children: [
              IconButton(onPressed: (){
                Get.back();
              },
                  icon: Icon(Icons.arrow_back)),

            ],),
            SizedBox(height: 30,),


            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text("Forget Password",style: Textstyle.title,),
                ],
              ),
            ),


            Text("Please enter you email to reset password",style: Textstyle.body,),
            SizedBox(height: 30,),
            Textfields(
              controller:controller.emailcontroller ,
              readOnly: controller.isEmailLocked.value,
              obscureText: false,
              hintText: " Enter you email",
              validator: Validation.email,
              prefixIcon: Icon(Icons.email),
            ),

            Obx(()=>
               Appbutton(
                text: "send Otp",
                isLoading: controller.isloading.value,
                onPressed:
                    (){
                  if( controller.formKey.currentState!.validate()){
                    controller.forpassword();
                  }
                }
              ),
            )
          ],
        ),
      ),

    );
  }
}
