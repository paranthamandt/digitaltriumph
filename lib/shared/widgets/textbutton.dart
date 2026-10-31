import 'package:firstapipro/core/theme/appcolor.dart';
import 'package:flutter/material.dart';

import '../../core/theme/textstyle.dart';
class Textbutton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final String? label;
  const Textbutton({super.key,
  required this.text,
    required this.onPress,
    this.label
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          // backgroundColor: Appcolor.warning
        ),
        onPressed: onPress,
        child:Text(text,style:  Textstyle.title,),
    );


  }
}
