class Customerupdateprofilemodel {
  final bool? success;
  String?name;
  String?gender;
  String?meassage;
  Customerupdateprofilemodel({
   this.success,
   this.name,
   this.gender,
   this.meassage
});

  factory Customerupdateprofilemodel.fromJson(Map<String,dynamic>json){
    final data=json["data"];
    final value=(data is Map ?(data["Customer"]??data):json) as Map;
    return Customerupdateprofilemodel(
        success:json["success"]as bool?,
        meassage:json["message: "]?.toString(),
     name:value["name"].toString(),
     gender: value["gender"].toString()
    );

  }

}