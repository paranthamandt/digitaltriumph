import 'dart:math';

import 'package:get/get.dart';

import '../../core/network/apiexception.dart';
import '../../core/utils/snackbar.dart';
import '../../data/models/categorieschipsmodel.dart';
import '../../data/models/searchcategory.dart';
import '../../data/repositories/loginreposites.dart';
class Searchscreenviewmodel  extends GetxController{
  final Loginreposites repository = Loginreposites();
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final items=<Searchcategory>[].obs;
  final query="".obs;
  final selectedCategory = Rxn<String>();
  final categorieschips = <Categorieschipsmodel>[].obs;
  final divisions = <Categorieschipsmodel>[].obs;
  final suppliers = <Categorieschipsmodel>[].obs;
  // final categorieschips = <Categorieschipsmodel>[].obs;

  final selectedDivisions = <String>{}.obs;
  final selectedSuppliers = <String>{}.obs;
  final selectedCategories = <String>{}.obs;

  int get activeFilterCount =>
      selectedDivisions.length +
          selectedSuppliers.length +
          selectedCategories.length;

  List<Searchcategory>get FilteredItems{
    final product=query.value.trim().toLowerCase();
    final cat = selectedCategory.value;
    return items.where((e) {
      final matchesText = product.isEmpty ||
          (e.name ?? '').toLowerCase().contains(product) ||
          (e.code ?? '').toLowerCase().contains(product);
      final matchesCat = cat == null || e.categoryName == cat;
      return matchesText && matchesCat;
    }).toList();
    // if(product.isEmpty)return items;
    // return items.where((e)=>(e.name ??"").toLowerCase().contains(product)).toList();
}
//   List<Searchcategory> get FilteredItems {
//     final q = query.value.trim().toLowerCase();
//     final divs = selectedDivisions.toSet();
//     final sups = selectedSuppliers.toSet();
//     final cats = selectedCategories.toSet();
//
//     return items.where((e) {
//       final matchesText = q.isEmpty ||
//           (e.name ?? '').toLowerCase().contains(q) ||
//           (e.code ?? '').toLowerCase().contains(q);
//       final matchesDiv = divs.isEmpty || divs.contains(e.divisionName);
//       final matchesCat = cats.isEmpty || cats.contains(e.categoryName);
//       final matchesSup = sups.isEmpty || sups.contains(e.supplierName);
//       return matchesText && matchesDiv && matchesCat && matchesSup;
//     }).toList();
//   }
  void onsearched(String value)=>query.value=value;
  void applyFilters(Set<String> d, Set<String> s, Set<String> c) {
    selectedDivisions.assignAll(d);
    selectedSuppliers.assignAll(s);
    selectedCategories.assignAll(c);
  }

  void clearFilters() => applyFilters({}, {}, {});




  void onCategorySelected(String? value) => selectedCategory.value = value;


  @override
  void onInit() {
    super.onInit();
    loadproduct();
    getcaterieschips();
  }


  Future<void>loadproduct()async{
    isLoading.value=true;
    errorMessage.value="";
    try{
      items.assignAll(await repository.searchproduct());

    }on ApiException catch(e){
      errorMessage.value=e.message;
      Snackbar.Showerror(e.message);
    }
    catch(e){
      errorMessage.value="something want wrong";
    }
    finally{
      isLoading.value=false;
    }
  }

  // Future<void> getcaterieschips() async {
  //   try {
  //     divisions.assignAll(await repository.getdivisions());
  //   } catch (e) {
  //
  //   }
  //   try {
  //     suppliers.assignAll(await repository.getsuppliers());
  //   } catch (e) {
  //
  //   }
  //   try {
  //     categorieschips.assignAll(await repository.getcategories());
  //   } catch (e) {
  //
  //   }
  // }
  Future<void> getcaterieschips() async {
    try {
      divisions.assignAll(await repository.getdivisions());
    } on ApiException catch (e) {
      Snackbar.Showerror(e.message);
    } catch (e) {
      Snackbar.Showerror('Failed to load divisions');
    }

    try {
      suppliers.assignAll(await repository.getsuppliers());
    } on ApiException catch (e) {
      Snackbar.Showerror(e.message);
    } catch (e) {
      Snackbar.Showerror('Failed to load suppliers');
    }

    try {
      categorieschips.assignAll(await repository.getcategories());
    } on ApiException catch (e) {
      Snackbar.Showerror(e.message);
    } catch (e) {
      Snackbar.Showerror('Failed to load categories');
    }
  }

// Future<void> getcaterieschips() async {
  //   isLoading.value = true;
  //   errorMessage.value = "";
  //   try {
  //     categorieschips.assignAll(await repository.getcategories());
  //   } on ApiException catch (e) {
  //     errorMessage.value = e.message;
  //     Snackbar.Showerror(e.message);
  //   } catch (e) {
  //     errorMessage.value = "Something went wrong";
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

}