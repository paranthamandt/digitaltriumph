 class Mobileloginmodel {
  final String phone;
  final String otp;
  Mobileloginmodel({required this.phone,required this.otp});
   Map<String,dynamic>toJson()=>{
     "phone":phone,
     "otp":otp
   };

 }