import 'package:firstapipro/core/theme/appcolor.dart';
import 'package:firstapipro/modules/view/loginscreen.dart';
import 'package:firstapipro/modules/view/profilescreen.dart';
import 'package:firstapipro/modules/view/searchscreen.dart';
import 'package:firstapipro/modules/viewmodel/homeviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:firstapipro/shared/widgets/textfields.dart';

import '../../core/storageservices/serviceskey.dart';
import '../../core/theme/textstyle.dart';
import '../../shared/widgets/Appbar.dart';
import '../../shared/widgets/buttonlogin.dart';
import '../../shared/widgets/elevatebutton.dart';
import 'package:get/get.dart';

import 'dashbordscreen.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});
  final Homeviewmodel controller=Get.put(Homeviewmodel());
  final List<Widget> pages=[

    Dashbordscreen(),
    Searchscreen(),
    Profilescreen(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(



      body: Obx(
            () => IndexedStack(
          index: controller.seletedIndex.value,
          children: pages,
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Obx(
              () => Container(height: 70,
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 12,
                  offset:Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: MediaQuery.removePadding(
                context: context,
                removeBottom: true,
                child: BottomNavigationBar(
                  currentIndex: controller.seletedIndex.value,
                  onTap: controller.changeTab,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  selectedItemColor: Appcolor.backgroundColor,
                  unselectedItemColor: Color(0xFF91A1BC),
                  selectedFontSize: 13,
                  unselectedFontSize: 13,
                  iconSize: 28,
                  selectedLabelStyle: Textstyle.body1,
                  unselectedLabelStyle: Textstyle.body1,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      activeIcon: Icon(Icons.home_rounded),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search_rounded),
                      label: 'Search',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle_outlined),
                      activeIcon: Icon(Icons.account_circle),
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

    );}}
