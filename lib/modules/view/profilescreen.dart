import 'package:firstapipro/core/theme/appcolor.dart';
import 'package:firstapipro/modules/view/Editscreen.dart';
import 'package:firstapipro/modules/viewmodel/profilescreenviewmodel.dart';
import 'package:firstapipro/routes/apppage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/widgets/Alertdialog.dart';
import '../../shared/widgets/profilephoto.dart';
import '../../shared/widgets/profilewidget.dart';
class Profilescreen extends StatelessWidget {
   Profilescreen({super.key});
  final Profilescreenviewmodel controller=Get.put(Profilescreenviewmodel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [SizedBox(height: 50,),
          // ProfilePhoto(),
          SizedBox(height: 30,),
          Profilewidget(
            text: "My Profile",
            icon:Icons.person,
            onPressed: () {
              // Get.toNamed(Apppage.Editscreen);
              Get.to(()=>Editscreen(),
              );
            },
          ),
          Profilewidget(
            text: "Logout",
            icon:Icons.logout,
            onPressed:
               (){
               Alertdialog.logout

               (controller.logout);
            }
          )
        ],
      ),
    );
  }
}
