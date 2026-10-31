class Categorieschipsmodel {
  final String id;
  final String name;

  Categorieschipsmodel({required this.id, required this.name});

  factory Categorieschipsmodel.fromJson(Map<String, dynamic> json) {
    return Categorieschipsmodel(
      id: json["_id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
    );
  }

}