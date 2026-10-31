import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Textfields extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController?controller;
   final bool obscureText;
  final String? Function(String?)? validator;
  final Widget?prefixIcon;
  final Widget? SufficIcon;
  final bool isPassword;
  final int? maxLength;
  final TextInputType?keyboardType;
  final List<TextInputFormatter>?inputFormatters;
  final bool readOnly;
  final String? prefixText;

  const Textfields({super.key,
    this.hintText,
     this.labelText,
   this.controller,
    this.obscureText=false,
    this.validator,
    this.prefixIcon,
    this.SufficIcon,
    this.isPassword=false,
    this.maxLength,
    this.keyboardType,
    this.inputFormatters,
    this.readOnly=false,
    this.prefixText
  });

  @override
  State<Textfields> createState() => _TextfieldsState();
}

class _TextfieldsState extends State<Textfields> {
  bool isPasswordHidden=true;
  @override

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        controller:widget.controller,
        obscureText: widget.isPassword&&isPasswordHidden,
        validator: widget.validator,
          readOnly: widget.readOnly,
          keyboardType: widget.keyboardType,
          maxLength:widget.maxLength,
          inputFormatters:widget.inputFormatters,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixText: widget. prefixText,
          labelText: widget.labelText,
            filled: true,
            fillColor: const Color(0xFFE8F8F3),
            prefixIconColor: const Color(0xFF16B995),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPassword?IconButton(onPressed: (){
              setState(() {
                isPasswordHidden=!isPasswordHidden;
              });
            },
                icon: Icon(isPasswordHidden?Icons.visibility_off_outlined:Icons.visibility_outlined)):null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color(0xFFB7DCD0),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color(0xFF16B995),
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.5,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 13,
            ),



            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12)
            )
        ),




      ),
    );
  }
}
