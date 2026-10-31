import 'package:firstapipro/core/network/apiexception.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import '../../core/storageservices/serviceskey.dart';
import '../../core/utils/snackbar.dart';
import '../../data/repositories/loginreposites.dart';
import 'dashbordscreenviewmodel.dart';
class Editscreenviewmodel  extends GetxController{
  final Loginreposites repository=Loginreposites();
  final namecontroller=TextEditingController();
  final emailcontroller=TextEditingController();
  final phonecontroller=TextEditingController();
  final isLoading=false.obs;
  final isSaving=false.obs;
  final isEditing = false.obs;
  final formKey=GlobalKey<FormState>();
  final List<String> genders = ["Male", "Female", "Other"];
  final Rxn<String> selectedGender = Rxn<String>();

  final isUploading = false.obs;
  final imageUrl = RxnString();


  String originalName = "";
  String? originalGender;
  void startEdit() => isEditing.value = true;

  void cancelEdit() {
    namecontroller.text = originalName;
    selectedGender.value = originalGender;
    isEditing.value = false;
  }

  @override
  void onInit(){
    super.onInit();
    profile();
  }

  Future<void>profile()async{
    isLoading.value=true;
    try{
      final pro=await repository.getprofile();
      namecontroller.text=pro.name??"";
      emailcontroller.text=pro.email??"";
      phonecontroller.text=pro.phone??"";
      selectedGender.value = genders.contains(pro.gender) ? pro.gender : null;
      originalName = namecontroller.text;
      originalGender = selectedGender.value;
      // imageUrl.value = Serviceskey.customer?["profileImage"]?.toString();
      // imageUrl.value = Serviceskey.profileImage;
      // final raw = Serviceskey.profileImage?.trim();
      // imageUrl.value = (raw == null || raw.isEmpty || raw.toLowerCase() == 'null')
      //     ? null
      //     : raw;
      // print('PROFILE IMAGE = "${imageUrl.value}"');
      imageUrl.value = Serviceskey.profileImageFor(pro.email ?? '');
    }
    on ApiException catch(e){
      Snackbar.Showerror(e.message);
    }
    finally {
      isLoading.value = false;
    }
  }

  Future<void>edit()async{
    if (!formKey.currentState!.validate()) return;
    if (isSaving.value) return;
    isSaving.value = true;
    try {
      final name = namecontroller.text.trim();
      final gender = selectedGender.value;

      final result = await repository.updateprofile(
        name: name,
        gender: gender,
        image: imageUrl.value,
      );

      if (result.success == false) {
        Snackbar.Showerror(result.meassage ?? "Update failed");
        return;
      }

      final savedGender = result.gender ?? gender;
      await Serviceskey.updateCustomer({
        "name": result.name ?? name,
        if (savedGender != null) "gender": savedGender,

      });
      originalName = name;
      originalGender = savedGender;
      isEditing.value = false;
      if (Get.isRegistered<Dashbordscreenviewmodel>()) {
        Get.find<Dashbordscreenviewmodel>().loadCustomerData();
      }




    } on ApiException catch (e) {
      Snackbar.Showerror(e.message);
    } catch (e) {
      print("PROFILE UPDATE ERROR: $e");
      Snackbar.Showerror("Something went wrong: $e");
    } finally {
      isSaving.value = false;
    }
  }
  Future<void> pickAndUpload() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked == null) return;

    isUploading.value = true;
    try {
      final result = await repository.uploadImage(picked.path);


      if (result.url != null && result.url!.isNotEmpty) {
        imageUrl.value = result.url;

        await Serviceskey.saveProfileImage(emailcontroller.text, result.url);
      }

    } on ApiException catch (e) {
      Snackbar.Showerror(e.message);
    } catch (e) {
      Snackbar.Showerror("Upload failed: $e");
    } finally {
      isUploading.value = false;
    }
  }




  }




