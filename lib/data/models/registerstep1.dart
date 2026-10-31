class Registerstep1 {
  final String phone;
  final String name;

  Registerstep1({
    required this.phone,
    required this.name
});
  Map<String,dynamic> toJson()=>{
    "phone":phone,
    "name":name
  };
}