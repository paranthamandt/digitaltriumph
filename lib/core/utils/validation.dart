 class Validation {

   static final emailPattern =
   RegExp( r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',);


   static final RegExp strongPassword = RegExp(
     r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^A-Za-z0-9\s]).{8,}$',
   );

   static bool isPasswordStrong(String password) =>
       strongPassword.hasMatch(password);

   static String? password(String? value) {
     if (value == null || value.isEmpty) return 'Password is required';
     if (value.length < 8) return 'Password must be at least 8 characters';
     if (!isPasswordStrong(value)) {
       return 'Use uppercase, lowercase, a number and a special character';
     }
     return null;
   }

   static String? email(String? value) {
     final input = value?.trim() ?? '';
     if (input.isEmpty) return 'Email is required';
     if (!emailPattern.hasMatch(input)) return 'Enter a valid email address';
     return null;
   }

   static String? name(String? value) {
     if (value == null || value.trim().isEmpty) {
       return "Please enter your name";
     }
     return null;
   }

   static String? phone(String? value) {
     if (value == null || value.trim().isEmpty) {
       return "Please enter your phone number";
     }
     return null;
   }
   static String? otp(String? value) {
     if (value == null || value.trim().isEmpty)
     {
       return 'Please enter OTP';
     }
     if (!RegExp(r'^\d{6}$').hasMatch(value.trim()))
     {
       return 'OTP must be exactly 6 digits';
     }
     return null; }

 }