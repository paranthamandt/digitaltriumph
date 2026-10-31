import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
class Otpwigtes extends StatelessWidget {
  final int length;
  final TextEditingController? controller;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final bool obscureText;

  Otpwigtes({super.key,
 this.length=6,
    this.controller,
    this.onCompleted,
    this.onChanged,
    this.validator,
    this.obscureText=false

   });

  @override
  Widget build(BuildContext context) {
    final defalutTheme=PinTheme(
      height:56,
      width:56,
      textStyle:TextStyle(fontSize: 22),
      decoration:BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12)
      )
    );
    return Pinput(
      length: length,
      controller: controller,
      obscureText: obscureText,
      defaultPinTheme: defalutTheme,
      focusedPinTheme: defalutTheme.copyWith(
        decoration:defalutTheme.decoration!.copyWith(border:Border.all(color: Theme.of(context).primaryColor, width: 2),

      )
      ),
        errorPinTheme:defalutTheme.copyWith(
          decoration:defalutTheme.decoration!.copyWith(border: Border.all(color: Colors.red),)
        ) ,

    validator: validator,
    onChanged: onChanged,
    onCompleted: onCompleted,
    );

  }
}
