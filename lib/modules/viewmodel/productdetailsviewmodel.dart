import 'package:firstapipro/core/network/apiexception.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/snackbar.dart';
import '../../data/models/productiteams.dart';
import '../../data/repositories/loginreposites.dart';
class Productdetailsviewmodel  extends GetxController{
  final Loginreposites repository =Loginreposites();
  final String productId;
  Productdetailsviewmodel(this.productId);
  final isLoading=false.obs;
  final errorMessage="".obs;
  final product=Rxn<Productiteams>();

  @override
  void onInit() {

    super.onInit();
    getproductdetails(productId);
  }

  Future<void>getproductdetails(String id)async{
   isLoading.value=true;
   errorMessage.value="";
   try{
     product.value=await repository.getiteamsdetails(id);


   }
   on ApiException catch (e){
     errorMessage.value=e.message;
     Snackbar.Showerror(e.message);
   }
   catch(e){
     errorMessage.value="something is wrong";
   }
   finally{
     isLoading.value=false;
   }
  }

}