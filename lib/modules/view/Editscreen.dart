import 'package:firstapipro/modules/viewmodel/Editscreenviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/textstyle.dart';
import '../../core/utils/validation.dart';
import '../../shared/widgets/appbutton.dart';
import '../../shared/widgets/dropdownbutton.dart';
import '../../shared/widgets/profilephoto.dart';
import '../../shared/widgets/textbutton.dart';
import '../../shared/widgets/textfields.dart';
class Editscreen extends StatelessWidget {
   Editscreen({super.key});
 final Editscreenviewmodel controller=Get.put(Editscreenviewmodel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
       Obx(
             () => controller.isLoading.value
             ?  Center(child: CircularProgressIndicator()):
          SingleChildScrollView(
           child: Form(
             key:controller.formKey,
             child: Column(children: [
              SizedBox(height: 50,),
              Row(children: [
                IconButton(onPressed: (){
                  Get.back();
                },
                    icon: Icon(Icons.arrow_back))
              ],),

               ProfilePhoto(
                 onCameraTap: controller.pickAndUpload,
                 imageUrl: controller.imageUrl.value,
                 isLoading: controller.isUploading.value,
               ),

              SizedBox(
              height: 40,
                   ),

              Textfields(

                controller: controller.namecontroller,
                hintText: "enter you name",
                validator: Validation.name,
              ),
              Textfields(

                controller: controller.emailcontroller,
                hintText: "enter you email",
                validator: Validation.email,
                readOnly: true,

              ),
              Textfields(

                controller: controller.phonecontroller,
                hintText: "enter you phone",
                readOnly: true,

              ),
               Dropdownbutton(
                 hintText: 'Select Gender',
                 items: controller.genders,
                 value: controller.selectedGender.value,
                 onChanged: (value) => controller.selectedGender.value = value,
               ),



                         Appbutton(
                           text: "Save",
                           isLoading: controller.isSaving.value,
                           onPressed: controller.edit,
                         ),

                   ],),
           ),
         ),
       )
      );

  }
}
