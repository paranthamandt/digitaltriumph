class Apiconstants {
  static  const  String  baseurl="https://api.spectra.digitaltriumph.co.in/api";

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const String registerStep1 = '/customer/auth/register/step1';
  static const String registerStep2 = '/customer/auth/register/step2';
  static const String registerStep3 = '/customer/auth/register/step3';
  static const String registerStep4 = '/customer/auth/register/step4';
  static const String LoginEmail="/customer/auth/login/email";
  static const String loginMobileRequestOtp =
      '/customer/auth/login/mobile/request-otp';
  static const String loginMobileVerifyOtp =
      '/customer/auth/login/mobile/verify-otp';
  static const String profile = '/customer/profile';
   static const String updateProfile=  "/customer/profile";

     static const String upload="/customer/upload";

      static const String forgotpassword="/customer/auth/forgot-password";
       static const String forgotpasswordresend="/customer/auth/forgot-password/resend";

        static const String newpasswordset="/customer/auth/reset-password";


static const String  products="/customer/products";
           static const String search="/customer/products";
             static  String productItem(String id)=>"/customer/products/$id";

              static const String productsuppliers= "/customer/products/suppliers";

              static const String categorieschips="/customer/products/categories";
                   static const String divisions="/customer/products/divisions";

                    static const String refreshtoken="/customer/auth/refresh-token";


}