import 'package:firstapipro/modules/view/productdetailsscreen.dart';
import 'package:firstapipro/modules/viewmodel/searchscreenviewmodel.dart';
import 'package:firstapipro/shared/widgets/cardProuct.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/apppage.dart';
import '../../shared/widgets/FilterChips.dart';
import '../../shared/widgets/FilterSheet.dart';
import '../../shared/widgets/homecard.dart';
import '../../shared/widgets/searchfield.dart';

class Searchscreen extends StatelessWidget {
   Searchscreen({super.key});
  final Searchscreenviewmodel controller=Get.put(Searchscreenviewmodel());
   // void _openFilters(BuildContext context) {
   //   showModalBottomSheet(
   //     context: context,
   //     isScrollControlled: true,
   //     shape: const RoundedRectangleBorder(
   //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
   //     ),
   //     builder: (_) => FilterSheet(controller: controller),
   //   );
   // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [SizedBox(height: 40,),
            SearchField(
             onChanged: controller.onsearched,
              // filterCount: controller.activeFilterCount,
              // onFilterTap: () => _openFilters(context),
            ),
            Obx(() => FilterChips(
              options: controller.categorieschips.map((c) => c.name).toList(),
              selected: controller.selectedCategory.value,
              onSelected: controller.onCategorySelected,
              // onFilterTap: () => _openFilters(context),
            )),

            Expanded(child: Obx((){
              if (controller.isLoading.value){
            return const Center(child: CircularProgressIndicator());

            }
              final results = controller.FilteredItems;
              if (results.isEmpty) {
                return const Center(child: Text('No products found.'));
              }

              return GridView.builder(itemCount: results.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,mainAxisSpacing: 8,crossAxisSpacing: 8,childAspectRatio: 0.66,

                  ),
                  itemBuilder: (context,index){
                final value=results[index];
                   return Cardprouct(
                       image: value.image??"",
                       name: value.name??"",
                       code: value.code??"",
                        description: value.description,
                 onTap: () {
               if (value.id !=null) {
                 Get.toNamed(Apppage.Productdetailsscreen, arguments: value.id);

               }}
                   );
               //  HomeProductCard(
               //    product: p,
               //    onTap: () {
               //      if (p.id.isNotEmpty) {
               //        Get.toNamed(Apppage.Productdetailsscreen, arguments: p.id);
               //      }
               //    },
               //  ),




                  }
                  );

            }
            )
            )



          ],
        ),
      ),
    );
  }
}

