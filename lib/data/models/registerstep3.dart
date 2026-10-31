class Registerstep3 {
  final String phone;
  final String email;
  final String password;

 Registerstep3({
    required this.phone,
    required this.email,
   required this.password
  });
  Map<String,dynamic> toJson()=>{
    "phone":phone,
    "email":email,
    "password":password
  };
}