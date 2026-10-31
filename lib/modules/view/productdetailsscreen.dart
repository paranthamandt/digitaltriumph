import 'package:firstapipro/modules/viewmodel/productdetailsviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/textstyle.dart';

class  Productdetailsscreen extends StatelessWidget {
  final String productId;
    Productdetailsscreen({super.key,required this.productId});
   late final Productdetailsviewmodel controller=Get.put(Productdetailsviewmodel(productId),tag: productId,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:Column(children: [  SizedBox(height: 30,),
       Row(
         children: [
           IconButton(onPressed: (){
             Get.back();
           },
               icon: Icon(Icons.arrow_back)),
         ],
       ),

     Expanded(
       child: Obx(() {
         if (controller.isLoading.value) {
           return  Center(child: CircularProgressIndicator());
         }
         if (controller.errorMessage.value.isNotEmpty) {
           return Center(child: Text(controller.errorMessage.value));
         }
         final item = controller.product.value;
         if (item == null) {
           return  Center(child: Text("No details found"));
         }
         // return ListView.builder(
         //   itemCount: controller.product.length,
         //   itemBuilder: (context, index) {
         //     final item = controller.product[index];
         //     return ListTile(title: Text(item.name ?? ''));
         //   },
         // );
         //
         return ListView(
           padding: const EdgeInsets.all(16),
           children: [
             if (item.images.isNotEmpty)
               Image.network(
                 item.images.first,
                 width: double.infinity,
                 height: 250,
                 fit: BoxFit.cover,
                 errorBuilder: (_, __, ___) =>
                 const Icon(Icons.image_not_supported, size: 80),
               ),
             const SizedBox(height: 16),
             Text(item.name ?? '', style: Textstyle.title),
             const SizedBox(height: 4),
             Text('Code: ${item.code ?? ''}', style: Textstyle.body1),
             if (item.warrantyMonths != null)
               Text('Warranty: ${item.warrantyMonths} months',
                   style: Textstyle.body1),
             const SizedBox(height: 12),
             if ((item.description ?? '').isNotEmpty)
               Text(item.description!, style: Textstyle.body1),
             if (item.keyFeatures.isNotEmpty) ...[
               const SizedBox(height: 16),
               Text('Key features', style: Textstyle.body1),
               ...item.keyFeatures.map((f) => Padding(
                 padding: const EdgeInsets.only(top: 4),
                 child: Text('=> $f',style: Textstyle.body1,),
               )),
             ],
             if (item.specifications.isNotEmpty) ...[
               const SizedBox(height: 16),
               Text('Specifications', style: Textstyle.body1),
               ...item.specifications.map((s) => Padding(
                 padding: const EdgeInsets.only(top: 4),
                 child: Text('${s["label"]}: ${s["value"]}',style: Textstyle.body1,),
               )),
             ],
           ],
         );
       }),
     ),


       ]),
     );//
    ///
    //
    // /,
    //  ],));///
  }//
}//
