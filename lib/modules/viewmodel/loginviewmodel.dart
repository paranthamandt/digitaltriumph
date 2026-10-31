import 'package:firstapipro/core/network/apiexception.dart';
import 'package:firstapipro/data/repositories/loginreposites.dart';
import 'package:firstapipro/modules/view/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/storageservices/serviceskey.dart';
import '../../core/utils/snackbar.dart';
import '../../routes/apppage.dart';

class Loginviewmodel  extends GetxController{
final Loginreposites repository=Loginreposites();
final isLoading = false.obs;
Future<void>login({
  required String email,
  required String password,
})
  async {
  if (isLoading.value) return;
  isLoading.value = true;
    try {
      final response = await repository.LoginEmail(email: email,
          password: password);
      final accessToken = response.accessToken;
      final refreshToken = response.refreshToken;
      if (accessToken == null || refreshToken == null)
      {
        Snackbar.Showerror("Login error");
        return;
      }
        await Serviceskey.saveLogin
          (accessToken: accessToken,
            refreshToken: refreshToken,
            customer: response.customer);
        Snackbar.ShowSuccess("Login Successfully");
      // await Future.delayed(Duration(seconds: 3));
        Get.offAll(() => Homescreen());
      }

    on ApiException catch (e) {
      Snackbar.Showerror(e.message);
    }
    catch(e){
      Snackbar.Showerror("Something went wrong: $e");
    }
    finally{
      isLoading.value=false;
    }
  }
}