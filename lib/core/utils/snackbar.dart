import 'package:firstapipro/core/theme/appcolor.dart';
import 'package:get/get.dart';
class Snackbar {
  static void  ShowSuccess(String message){
    Get.snackbar("Success",
        message,
      backgroundColor: Appcolor.success
    );
    Appcolor.success;
  }
  static void  Showerror(String message){
    Get.snackbar("Error",
        message,
      backgroundColor: Appcolor.error
    );
    Appcolor.error;

  }
}