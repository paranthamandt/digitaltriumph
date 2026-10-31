
import 'dart:math';

import 'package:firstapipro/core/constants/apiconstants.dart';
import 'package:firstapipro/core/network/apiclient.dart';
import '../../core/storageservices/serviceskey.dart';
import '../models/Customerupdateprofilemodel.dart';
import '../models/Uploadmodel.dart';
import '../models/categorieschipsmodel.dart';
import '../models/customerprofilemodel.dart';
import '../models/loginmodel.dart';
import '../models/mobileloginotpmodel.dart';
import '../models/productCategory.dart';
import '../models/productiteams.dart';
import '../models/refreshtokenmodel.dart';
import '../models/searchcategory.dart';

class Loginreposites {
  final Apiclient apiclient = Apiclient();

  Future<Map<String, dynamic>> registerStep1({
    required String phone,
    required String name,
    String?gender,
     String? clinicalRole
  }) async {
    final Map<String, dynamic>payload = {
      "phone": phone,
      "name": name,
      if(gender!=null)"gender":gender,
      if(clinicalRole!=null)"clinicalRole":clinicalRole
    };
    final response = await apiclient.post(
        Apiconstants.registerStep1, data: payload);
    return response as Map<String, dynamic>;
  }

  Future<void> registerStep2({
    required String phone,
    required String otp,
  }) async {
    await apiclient.post(
        Apiconstants.registerStep2, data: { "phone": phone, "otp": otp});
  }


  Future<void> registerStep3({
    required String phone,
    required String email,
    required String password,
  }) async {
    await apiclient.post(Apiconstants.registerStep3,
        data: {
      "phone": phone,
           "email": email, "password": password});
  }


  Future<dynamic> registerStep4({
    required String email,
    required String otp,
  }) async {
    final response=await apiclient.post(
        Apiconstants.registerStep4, data: { "email": email, "otp": otp});
    return response;
  }


  Future<Loginmodel> LoginEmail({
    required String email,
    required String password,
  }) async {
    final response = await apiclient.post(
      Apiconstants.LoginEmail,
      data: {"email": email, "password": password},
    );
    return Loginmodel.fromJson(response as Map<String, dynamic>);
  }

  Future <Map<String,dynamic>>Mobilelogin({
    required String phone
})async{
    final response= await apiclient.post(Apiconstants.loginMobileRequestOtp,data: {"phone":phone});
    return  response as Map<String,dynamic>;
  }



  Future<Mobileloginotpmodel>Mobileotplogin({
    required String phone,
    required String otp
})async{
    final response=await apiclient.post(Apiconstants.loginMobileVerifyOtp,data: {
      "phone":phone,"otp":otp
    });
    return Mobileloginotpmodel.fromJson(response as Map<String,dynamic>);
  }




 Future<Customerprofilemodel> getprofile() async {
 final response = await apiclient.get(Apiconstants.profile,
     headers: {
       "Authorization": "Bearer ${Serviceskey.accessToken}",
     },

 );  ////////////////
 return Customerprofilemodel.fromJson(response);
 }

 Future<Customerupdateprofilemodel>updateprofile({
    required String name,
     String?gender,
     String? image,
})async{
    final response=await apiclient.put(Apiconstants.updateProfile,data: {
      "name":name,if(gender!=null)"gender":gender,
      if (image != null) "profileImage": image,
    });
    return Customerupdateprofilemodel.fromJson(response);
 }




  Future<Uploadmodel> uploadImage(String filePath) async {
    final response = await apiclient.upload(
      Apiconstants.upload,
      filePath: filePath,
    );
    return Uploadmodel.fromJson(response as Map<String, dynamic>);
  }

  Future<dynamic> resendOtp({
    required String phone,
    required String name,
    required String gender,
  }) async {
    final response = await apiclient.post(
      Apiconstants.registerStep1,
      data: {
        "phone": phone,
        "name": name,
        "gender": gender,
        "clinicalRole": "customer",
      },
    );
    return response;
  }

  Future<String>forgotpassword(String email)async{

    final response=await apiclient.post(Apiconstants.forgotpassword,data:{ "email":email},);
    return response["message"]?.toString()??"otp send";
  }

  Future<String>forgotresendpasswordotp(String email)async{
    final response =await apiclient.post(Apiconstants.forgotpasswordresend,data: {"email":email,});
    return response["message"]?.toString()??"otp send again";
  }

  Future<String> resetPassword({
    required String email,
    required String otp,
    required String password,
  }) async {
    final response = await apiclient.post(
      Apiconstants.newpasswordset,
      data: {
        "email": email,
        "otp": otp,
        "newPassword": password,
      },
    );

    return response["message"]?.toString() ?? "Password reset successful";
  }




  ///
  Future<List<Productcategory>>getproduct()
    async{
      final response=await apiclient.get(Apiconstants.products);
      final data= (response as Map<String,dynamic>)["data"] as List? ??[];
      return  data .map((e)=>Productcategory.fromjson(e as Map<String,dynamic>))
      .toList();
    }

  Future<List<Searchcategory>>searchproduct()
  async{
    final response=await apiclient.get(Apiconstants.search);
    final data= (response as Map<String,dynamic>)["data"] as List? ??[];
    return  data .map((e)=>Searchcategory.fromJson(e as Map<String,dynamic>))
    .toList();
  }

  Future<Productiteams> getiteamsdetails(String id) async {
    final response = await apiclient.get(Apiconstants.productItem(id));
    final body = response as Map<String, dynamic>;
    final data = (body["data"] ?? body) as Map<String, dynamic>;
    return Productiteams.fromJson(data);
  }




  Future<List<Categorieschipsmodel>> getcategories() async {
    final response = await apiclient.get(Apiconstants.categorieschips);
    final body = response as Map<String, dynamic>;
    return (body['data'] as List)
        .map((e) => Categorieschipsmodel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
  Future<List<Categorieschipsmodel>> getdivisions() async {
    final response = await apiclient.get(Apiconstants.divisions);
    final data = (response as Map<String, dynamic>)["data"] as List? ?? [];
    return data
        .map((e) => Categorieschipsmodel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Categorieschipsmodel>> getsuppliers() async {
    final response = await apiclient.get(Apiconstants.productsuppliers);
    final data = (response as Map<String, dynamic>)["data"] as List? ?? [];
    return data
        .map((e) => Categorieschipsmodel.fromJson(e as Map<String, dynamic>))
        .toList();
  }


  Future<Refreshtokenmodel>refreshtoken()async{
    final response=await apiclient.post(Apiconstants.refreshtoken,data: {"refreshToken":Serviceskey.refreshToken});
    return Refreshtokenmodel.fromJson( response as Map<String, dynamic>,);
  }

  
  }






