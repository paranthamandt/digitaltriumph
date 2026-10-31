class Customerprofilemodel {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? gender;
  Customerprofilemodel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.gender
});
  factory Customerprofilemodel.fromJson(Map<String,dynamic>json){
    final value=(json["data"]?["customer"]??json["data"]??json)as Map;
    return Customerprofilemodel(
        id: (value["_id"] ?? value["id"])?.toString(),
      // id: value["id"]?.toString(),
      name: value["name"]?.toString(),
      email: value["email"]?.toString(),
      phone: value["phone"]?.toString(),
      gender: value["gender"]?.toString()
    );
  }
}