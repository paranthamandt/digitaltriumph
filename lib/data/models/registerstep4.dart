class Registerstep4 {
  final String email;
  final String otp;
  Registerstep4({
    required this.email,
    required this.otp
});
  Map<String,dynamic>toJson()=>{
    "email":email,
    "otp":otp

};
}