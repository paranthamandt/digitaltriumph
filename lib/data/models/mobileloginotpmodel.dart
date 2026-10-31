class Mobileloginotpmodel {
  final String? accessToken;
  final String? refreshToken;
  final bool newCustomer;
  final String? status;
  final bool isPhoneVerified;
  final bool isEmailVerified;
  final String? id;
  final Map<String, dynamic>? customer;

  Mobileloginotpmodel({
    this.accessToken,
    this.refreshToken,
    this.newCustomer = false,
    this.status,
    this.isPhoneVerified = false,
    this.isEmailVerified = false,
    this.id,
    this.customer,
  });

  factory Mobileloginotpmodel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map
        ? Map<String, dynamic>.from(json['data'])
        : json;

    final customerData = data['customer'] is Map
        ? Map<String, dynamic>.from(data['customer'])
        : <String, dynamic>{};

    return Mobileloginotpmodel(
      accessToken: data['accessToken']?.toString(),
      refreshToken: data['refreshToken']?.toString(),
      newCustomer: data['newCustomer'] == true,
      status: customerData['status']?.toString(),
      isPhoneVerified: customerData['isPhoneVerified'] == true,
      isEmailVerified: customerData['isEmailVerified'] == true,
      id: customerData['id']?.toString(),
      customer: customerData.isEmpty ? null : customerData,
    );
  }
}