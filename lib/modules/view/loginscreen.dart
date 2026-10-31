import 'package:firstapipro/core/utils/validation.dart';
import 'package:firstapipro/modules/view/mobileloginscreen.dart';
import 'package:firstapipro/modules/view/registerstep1screen.dart';
import 'package:firstapipro/modules/viewmodel/loginviewmodel.dart';
import 'package:firstapipro/routes/apppage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/appconstants.dart';
import '../../core/theme/appcolor.dart';
import '../../core/theme/textcolor.dart';
import '../../core/theme/textstyle.dart';
import '../../core/values/assets.dart';
import '../../shared/widgets/BlueBackground.dart';
import '../../shared/widgets/elevatebutton.dart';
import '../../shared/widgets/textfields.dart';
class Loginscreen extends StatelessWidget {
   Loginscreen({super.key});

  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final fromKey=GlobalKey<FormState>();
  final Loginviewmodel controller=Get.put(Loginviewmodel());


  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Appcolor.backgroundColor1,
      body:

      SingleChildScrollView(
        child: Padding(
              padding: Appconstants.Padding,
                child: Form(
                  key:fromKey,
                    child: Column(
                      children: [
                        Container(
                          height: 250,
                          width: double.infinity,
                          decoration:  BoxDecoration(),
                          child: Image.asset(
                            Assets.one,
                            fit: BoxFit.contain,
                          ),
                        ),
                               
        
                        Text("WelCome Back",style:Textstyle.heading,),
                        Text("Login to access you account",style: Textstyle.body,),
                         // SizedBox(height: 50,),
                         Row(
                           children: [
                             Text("Email",style: Textstyle.body,),
                           ],
                         ),
                        Textfields(
                            controller: emailController,
                            obscureText: false,
                            hintText: " Enter you email",
                          validator: Validation.email,
                          prefixIcon: Icon(Icons.email),
                        ),
                        // SizedBox(height: 30,),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("password",style: Textstyle.body,),
                            GestureDetector( onTap: (){
                              Get.toNamed(Apppage.Forgotpassword,arguments: {
                                "email":emailController.text.trim(),
                              });
                            }, child: Text("Forget password?",style:TextStyle( color:  TextColors.Color1,)))
                          ],
                        ),
                       
                       
                        Textfields(
                            controller: passwordController,
                            obscureText: true,
                            hintText: "Enter you  password",
                            validator:Validation.password,
                          prefixIcon: Icon(Icons.password),
                          isPassword: true,
                        ),
                       // Row(mainAxisAlignment: MainAxisAlignment.end,
                       //   children: [
                       // Text("Forget password?",style:TextStyle( color:  TextColors.Color1,))
                       //  ],),
                        // SizedBox(height: 40,),
                       
                        Elevatebutton(
                          height: 50,
                          width: double.infinity,
                          text: "Login",
                          onPressed: (){
                            if(fromKey.currentState!.validate()){
                              controller.login(email: emailController.text.trim(),
                                  password:passwordController.text);
                            }
                       
                       
                          },
                        ),
                        Row(children: [Expanded(child: Divider(thickness: 1,),),Text("OR SIGN IN WITH",style:Textstyle.body1 ,),Expanded(child: Divider(thickness: 1,))],),
                       SizedBox(height: 30,),
                        Row(children: [
                          Expanded(
                            child: Elevatebutton(
                              onPressed: (){
                                Get.to(()=>Mobileloginscreen());
                              },
                              height: 50,
                              width: double.infinity,
                              text: "Mobile Login  ",
                            ),
                          ),
                       
                       
                        ],),
                        // SizedBox(height: 50,),
                       
                       
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have account? ",style: Textstyle.body,),
                            TextButton(onPressed:
                            (){
                              Get.to(()=>Registerstep1screen());
                            },
                              child: Text("Signup",style: Textstyle.body,),
                            )
                          ],
                        )
                       
                      ],
                    ),
                  ),
                ),
      ),





    );
  }
}
