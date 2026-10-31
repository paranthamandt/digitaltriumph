class Refreshtokenmodel {


  final String accessToken;
  final String? refreshToken;

  Refreshtokenmodel({
  required this.accessToken,
  this.refreshToken,
  });

  factory Refreshtokenmodel.fromJson(Map<String, dynamic> json) {
  final data = json["data"] is Map
      ? Map<String, dynamic>.from(json["data"])
      : json;

  return Refreshtokenmodel(
  accessToken: data["accessToken"]as String,
  refreshToken: data["refreshToken"]as String?,
  );
  }

}