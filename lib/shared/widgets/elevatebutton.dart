import 'package:firstapipro/core/theme/appcolor.dart';
import 'package:flutter/material.dart';

import '../../core/theme/textstyle.dart';
class Elevatebutton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  const Elevatebutton({super.key,
  required this.text,
    required this.onPressed,
    required this.height,
    required this.width
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Appcolor.backgroundColor,
              foregroundColor: Appcolor.foregroundColor,
              elevation: 0,

            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
          ),
          onPressed: onPressed,
          child: Text(text,style: Textstyle.title,),
        ),
      ),
    );
  }
}
