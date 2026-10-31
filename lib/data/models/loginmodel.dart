import 'dart:convert';

class Loginmodel {
  final int? statusCode;
 final String? accessToken;
 final String? refreshToken;
  final Map<String, dynamic>? customer;
  final String? id;
final bool?isActive;
  final bool? isDeleted;
   final bool? isPhoneVerified;
   final bool?  isEmailVerified;
  Loginmodel({
    this.statusCode,
     this.accessToken,
     this.refreshToken,
     this.customer,
    this.isActive,
    this.isDeleted,
    this.isPhoneVerified,
    this.isEmailVerified,
    this.id
});

  factory Loginmodel.fromJson(Map<String,dynamic>json,){

    final data = json['data'] is Map
        ? Map<String, dynamic>.from(json['data'])
        : json;


    final customerData = data['customer'] is Map
        ? Map<String, dynamic>.from(data['customer'])
        : <String, dynamic>{};

    return Loginmodel(
      accessToken: data["accessToken"],
      refreshToken: data["refreshToken"],
        id: customerData["id"]?.toString(),
      isPhoneVerified: customerData["isPhoneVerified"]as bool?,
      isEmailVerified: customerData["isEmailVerified"]as bool?,
      isActive: customerData["isActive"]as bool?,
        isDeleted:customerData["isDeleted"]as bool?,


    );


  }
}
