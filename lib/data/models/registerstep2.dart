class Registerstep2 {
  final String phone;
  final String otp;

  Registerstep2({
    required this.phone,
    required this.otp
  });
  Map<String,dynamic> toJson()=>{
    "phone":phone,
    "otp":otp
  };
}