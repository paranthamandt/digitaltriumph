class Uploadmodel {
  final bool? success;
  final String? message;
  final String? url;

  Uploadmodel({this.success, this.message, this.url});

  factory Uploadmodel.fromJson(Map<String, dynamic> json) {
    final data = json["data"];
    return Uploadmodel(
      success: json["success"] as bool?,
      message: json["message"]?.toString(),
      url: (data is Map ? (data["url"] ?? data["path"]) : json["url"])?.toString(),
    );
  }
}