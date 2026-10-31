import 'package:firstapipro/modules/view/productdetailsscreen.dart';
import 'package:firstapipro/modules/view/searchscreen.dart';
import 'package:firstapipro/modules/viewmodel/dashbordscreenviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/storageservices/serviceskey.dart';
import '../../core/theme/textstyle.dart';
import '../../routes/apppage.dart';
import '../../shared/widgets/cardProuct.dart';
import '../../shared/widgets/homecard.dart';
import '../../shared/widgets/searchfield.dart';
import '../viewmodel/homeviewmodel.dart';
import '../viewmodel/searchscreenviewmodel.dart';

class Dashbordscreen extends StatelessWidget {
  Dashbordscreen({super.key});

  final Dashbordscreenviewmodel controller = Get.put(Dashbordscreenviewmodel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 70),

          Obx(
            () => Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    child:
                    Text("${controller.greeting}, ${controller.displayName}",style: Textstyle.cardTitle,
                    ),
                  ),
                ],
              ),
            ),
          ),

           SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return  Center(child: CircularProgressIndicator());
              }

              if (controller.errorMessage.value.isNotEmpty) {
                return Center(child: Text(controller.errorMessage.value));
              }

              if (controller.categories.isEmpty) {
                return  Center(child: Text("No products available"));
              }


              final groups = controller.groupedByCategory;
              return ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: groups.entries.map((entry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              entry.key,
                              style: Textstyle.body1,

                            ),
                            GestureDetector(
                              onTap: () {
                                Get.find<Searchscreenviewmodel>().selectedCategory.value = entry.key;
                                Get.find<Homeviewmodel>().changeTab(1);
                              },
                              child:  Row(
                                children: [
                                  Text(
                                    'View All',
                                    style: Textstyle.view
                                  ),
                                  Icon(Icons.chevron_right,
                                      size: 18,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 260,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: entry.value.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final p = entry.value[index];
                            return SizedBox(
                              width: 170,
                              child: HomeProductCard(
                                product: p,
                                onTap: () {
                                  if (p.id.isNotEmpty) {
                                    Get.toNamed(Apppage.Productdetailsscreen, arguments: p.id);
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }).toList(),
              );


            }//////
            ),
          ),
        ],
      ),
    );
  }
}
