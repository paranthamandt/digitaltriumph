 class Searchcategory {
  final String? id;
  final String? name;
  final String? image;
  final String? code;
  final String? categoryName;
  final String? divisionName;
  final String? supplierName;
  final String? description;

  Searchcategory({
    this.id,
    this.name,
    this.image,
    this.code,
    this.categoryName,
    this.divisionName,
    this.supplierName,
    this.description
 });
  factory Searchcategory.fromJson(Map<String,dynamic>json){
    final images = json["images"];
    final div = json["divisionId"];
    final sup = json["supplierId"] ?? json["supplier"];

    return Searchcategory(
      id:json["_id"]as String?,
       name:json["name"]?.toString()??"",

        code:json["code"]?.toString()??"",
        image: (images is List && images.isNotEmpty)
            ? images.first.toString()
            : null,

    categoryName: (json["categoryId"] is Map)
        ? json["categoryId"]["name"]?.toString()
        : null,
      divisionName: div is Map ? div["name"]?.toString() : null,
      supplierName: sup is Map ? sup["name"]?.toString() : null,
      description: json["description"]?.toString(),
    );
  }

  Map<String,dynamic>tojson()=>{
    "_id":id,
    "name":name,
    "image":image,
    "code":code,
    "categoryName":categoryName,
    "divisionName":divisionName,
    "supplierName":supplierName,
    "description":description
  };

 }