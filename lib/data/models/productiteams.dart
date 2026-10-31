
class Productiteams {
  final String? id;
  final String? name;
  final String? code;
  final String? description;
  final String? categoryName;
  final String? supplierName;
  final String? currency;
  final List<String> images;
  final List<String> keyFeatures;
  final List<Map<String, String>> specifications;
  final num? sellingPrice;
  final num? mrp;
  final int? warrantyMonths;

  Productiteams({
    this.id,
    this.name,
    this.code,
    this.description,
    this.categoryName,
    this.supplierName,
    this.currency,
    this.images = const [],
    this.keyFeatures = const [],
    this.specifications = const [],
    this.sellingPrice,
    this.mrp,
    this.warrantyMonths,
  });

  factory Productiteams.fromJson(Map<String, dynamic> json) {
    return Productiteams(
      id: json["_id"]?.toString(),
      name: json["name"]?.toString(),
      code: json["code"]?.toString(),
      description: json["description"]?.toString(),
      categoryName: (json["categoryId"] is Map)
          ? json["categoryId"]["name"]?.toString()
          : null,
      supplierName: (json["supplierId"] is Map)
          ? json["supplierId"]["supplierName"]?.toString()
          : null,
      currency: json["currency"]?.toString(),
      images: (json["images"] as List? ?? []).map((e) => e.toString()).toList(),
      keyFeatures:
      (json["keyFeatures"] as List? ?? []).map((e) => e.toString()).toList(),
      specifications: (json["specifications"] as List? ?? [])
          .whereType<Map>()
          .map((e) => {
        "label": (e["label"] ?? "").toString(),
        "value": (e["value"] ?? "").toString(),
      })
          .toList(),
      sellingPrice: json["sellingPrice"] as num?,
      mrp: json["mrp"] as num?,
      warrantyMonths: (json["warrantyMonths"] as num?)?.toInt(),
    );
  }
}
