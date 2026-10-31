import 'package:get/get.dart';

import '../../core/network/apiexception.dart';
import '../../core/storageservices/serviceskey.dart';
import '../../core/utils/snackbar.dart';
import '../../data/models/categorieschipsmodel.dart';
import '../../data/models/productCategory.dart';
import '../../data/models/searchcategory.dart';
import '../../data/repositories/loginreposites.dart';

class Dashbordscreenviewmodel extends GetxController {
  final Loginreposites repository = Loginreposites();
  final isLoading = false.obs;
  var username = ''.obs;
  var useremail = ''.obs;
  var profileImage = ''.obs;
  final categories = <Productcategory>[].obs;
  final errorMessage = ''.obs;
  final items=<Searchcategory>[].obs;
  final categoryList = <Categorieschipsmodel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCustomerData();
    loadcategories();
  }

  Future<void> loadCustomerData() async {
    final customer = Serviceskey.userBox.get('customerData');

    if (customer is Map) {
      username.value = customer["name"]?.toString() ?? '';

      useremail.value = customer["email"]?.toString() ?? '';

      profileImage.value = Serviceskey.profileImageFor(useremail.value) ?? '';
    }
    try {
      final pro = await repository.getprofile();
      username.value = pro.name ?? username.value;
      useremail.value = pro.email ?? useremail.value;
      await Serviceskey.updateCustomer({
        "name": username.value,
        "email": useremail.value,
      });
    } on ApiException catch (e) {
      Snackbar.Showerror(e.message);
    }

    profileImage.value = Serviceskey.profileImageFor(useremail.value) ?? '';
  }

  String get greeting {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  String get displayName =>
      username.value.isNotEmpty ? username.value : 'Customer';


  // Map<String, List<Productcategory>> get groupedByCategory {
  //   final map = <String, List<Productcategory>>{};
  //   for (final p in categories) {
  //     final key = (p.categoryName ?? '').isEmpty ? 'Others' : p.categoryName!;
  //     map.putIfAbsent(key, () => []).add(p);
  //   }
  //   return map;
  // }
  Map<String, List<Productcategory>> get groupedByCategory {
    final idToName = {for (final c in categoryList) c.id: c.name};
    final map = <String, List<Productcategory>>{};

    // 1. every category title from the API, in API order
    for (final c in categoryList) {
      map[c.name] = [];
    }

    // 2. put each product under its category
    for (final p in categories) {
      final name = idToName[p.categoryId] ??
          ((p.categoryName ?? '').isNotEmpty ? p.categoryName! : 'Others');

      map.putIfAbsent(name, () => []).add(p);
    }

    map.removeWhere((_, list) => list.isEmpty); // hide empty categories
    return map;
  }



  // Future<void> loadcategories() async {
  //   isLoading.value = true;
  //   errorMessage.value = '';
  //   try {
  //     categories.assignAll(await repository.getproduct());
  //   try {
  //     categoryList.assignAll(await repository.getcategories());
  //   }
  //   on ApiException catch (e) {
  //     errorMessage.value = e.message;
  //     Snackbar.Showerror(e.message);
  //   } catch (e) {
  //     errorMessage.value = 'Something went wrong. Please try again.';
  //   } finally {
  //     isLoading.value = false;
  //   }

  Future<void> loadcategories() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      categories.assignAll(await repository.getproduct());

      try {
        final list = await repository.getcategories();
        categoryList.assignAll(list);

      } catch (e, s) {

      }



      try {
        categoryList.assignAll(await repository.getcategories());
      } catch (_) {}
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      Snackbar.Showerror(e.message);
    } catch (e) {
      errorMessage.value = 'Something went wrong. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }
  }




// }
