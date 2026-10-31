// import 'dart:convert';
//
// class Productcategory {
//   final String id;
//   final String code;
//   final String name;
//   final String? image;
//   final String price;
//    final String? categoryName;
//   final String? categoryId;
//   final String? brand;
//   final String? description;
//   Productcategory({
//     required this.id,
//     required this.code,
//      required this.name,
//     this.categoryId,
//      required this.image,
//     required this.price,
//     this.categoryName,
//     this.brand,
//     this.description
//
// });
//   factory Productcategory.fromjson(Map<String,dynamic>json){
//
//
// final images = json["images"];
// final b = json["brand"];
// final cat = json["categoryId"] ?? json["category"];
// return Productcategory(
//       id:json["_id"]?.toString()??"",
//       code:json ["code"]?.toString()??"",
//       name:json["name"]?.toString()??"",
//
// //          image: (images is List && images.isNotEmpty)
// // ? images.first.toString()
// // : (json["image"]?.toString() ?? ""),
//
//         price: json["price"]?.toString()??"",
//         //
//         // categoryName: (json["categoryId"] is Map)
//         //     ? json["categoryId"]["name"]?.toString()
//         //     : null,
//
//         image: (images is List && images.isNotEmpty)
//             ? images.first.toString()
//             : null,
//
//         categoryName: (json["categoryId"] is Map)
//             ? json["categoryId"]["name"]?.toString()
//             : null,
//           categoryId: cat is Map ? cat["_id"]?.toString() : cat?.toString(),
//           brand: b is Map ? b["name"]?.toString() : b?.toString(),
//           description: json["description"]?.toString()
//       );
//       // );
//
// }
//   Map<String,dynamic>tojson()=>{
//     "_id":id,
//     "name":name,
//     "image":image,
//     "code":code,
//     "categoryName": categoryName,
//     "brand":brand,
//     "description":description,
//     "categoryId":categoryId
//
//
//   };
// }
class Productcategory {
  final String id;
  final String code;
  final String name;
  final String? image;
  final String price;
  final String? categoryId;
  final String? categoryName;
  final String? brand;
  final String? description;

  Productcategory({
    required this.id,
    required this.code,
    required this.name,
    this.image,
    required this.price,
    this.categoryId,
    this.categoryName,
    this.brand,
    this.description,
  });

  factory Productcategory.fromjson(Map<String, dynamic> json) {
    final images = json["images"];
    final cat = json["categoryId"];
    final b = json["brandId"] ?? json["brand"];
    print('FROMJSON categoryId raw: ${json["categoryId"]}');
    return Productcategory(
      id: json["_id"]?.toString() ?? "",
      code: json["code"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      price: (json["sellingPrice"] ?? json["price"])?.toString() ?? "",
      image: (images is List && images.isNotEmpty)
          ? images.first.toString()
          : json["image"]?.toString(),
      categoryId: cat is Map ? cat["_id"]?.toString() : cat?.toString(),
      categoryName: cat is Map ? cat["name"]?.toString() : null,
      brand: b is Map ? b["name"]?.toString() : null,
      description: json["description"]?.toString(),
    );
  }

  Map<String, dynamic> tojson() => {
    "_id": id,
    "name": name,
    "image": image,
    "code": code,
    "price": price,
    "categoryId": categoryId,
    "categoryName": categoryName,
    "brand": brand,
    "description": description,
  };
}

