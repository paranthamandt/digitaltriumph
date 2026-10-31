import 'package:firstapipro/core/constants/appconstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
class Serviceskey {
  static final userBox = Hive.box(Appconstants.userHiveBox);

  static const customerKey = "customerData";

  static Future<void> saveLogin({
    required String accessToken,
    required String refreshToken,
    Map<String, dynamic>?customer,
  }) async {
    await userBox.put("accessToken", accessToken);
    await userBox.put("refreshToken", refreshToken);
    await userBox.put("isLoggedIn", true);
    if (customer != null) await userBox.put(customerKey, customer);
  }

  static String? get accessToken => userBox.get("accessToken");
  static String? get refreshToken => userBox.get("refreshToken");

  static Map<String, dynamic>? get customer {
    final data = userBox.get(customerKey);
    return data == null ? null : Map<String, dynamic>.from(data);
  }

  static bool get isLoggedIn {
    String? checking = userBox.get("accessToken");
    return checking != null && checking.isNotEmpty;
  }

  static Future<void> updateCustomer(Map<String, dynamic> newData)
  async {
    final current = customer ?? <String,dynamic> {};
    final updateCustomer=<String,dynamic>{
     ... current,...newData,
    };

    await userBox.put(customerKey, updateCustomer);
  }

  static String? get profileImage => userBox.get("profileImage");


  static String _imageKey(String email) =>
      'profileImage_${email.trim().toLowerCase()}';

  static String? profileImageFor(String email) {
    if (email.trim().isEmpty) return null;
    final value = userBox.get(_imageKey(email))?.toString().trim();
    if (value == null || value.isEmpty || value.toLowerCase() == 'null') {
      return null;
    }
    return value;
  }

  static Future<void> saveProfileImage(String email, String? url) async {
    if (email.trim().isEmpty) return;
    if (url == null || url.isEmpty) {
      await userBox.delete(_imageKey(email));
    } else {
      await userBox.put(_imageKey(email), url);
    }
  }

  static Future<void> clear() async {
    final images = <String, dynamic>{};
    for (final key in userBox.keys) {
      if (key.toString().startsWith("profileImage_")) {
        images[key.toString()] = userBox.get(key);
      }
    }
    await userBox.clear();
    if (images.isNotEmpty) await userBox.putAll(images);
  }
}

