import 'package:firstapipro/core/theme/appcolor.dart';
import 'package:flutter/material.dart';

import '../../core/theme/textstyle.dart';
class Buttonlogin extends StatelessWidget {
  final String text;
  final VoidCallback onPress;

  const Buttonlogin({super.key,
  required this.text,
    required this.onPress

  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: Textstyle.body,
        backgroundColor: Appcolor.error,

      ),

        onPressed: (){},
        child: Text(text),


    );
  }
}
