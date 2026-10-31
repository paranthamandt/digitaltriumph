import 'package:firstapipro/modules/viewmodel/splashscreenviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/appcolor.dart';

class Splashscreen extends StatelessWidget {
   Splashscreen({super.key});
final Splashscreenviewmodel controller=Get.put(Splashscreenviewmodel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor:  Appcolor.backgroundColor,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
