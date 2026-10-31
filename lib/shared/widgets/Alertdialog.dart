import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/textstyle.dart';

class Alertdialog
{
  static void confirm({
    required String title,
    required String message,
    required VoidCallback onYes,
    String yesText = "Yes",
    String noText = "No",
    Color yesColor = Colors.red,
    TextStyle? titlestyle,
    TextStyle? messagestyle

  }) {
    Get.dialog(
      AlertDialog(
        title: Text(title,style: titlestyle),
        content: Text(message,style: messagestyle,),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(noText,style:Textstyle.body ,),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: yesColor,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Get.back();
              onYes();
            },
            child: Text(yesText,style: Textstyle.body,),
          ),
        ],
      ),
    );
  }


  static void logout(VoidCallback onYes) => confirm(
    title: "Logout",
    message: "Are you sure you want to logout?",
    onYes: onYes,
   titlestyle: Textstyle.heading,
   messagestyle: Textstyle.title
  );

  static void delete(VoidCallback onYes) => confirm(
    title: "Delete",
    message: "This can't be undone.",
    yesText: "Delete",
    onYes: onYes,
  );
}