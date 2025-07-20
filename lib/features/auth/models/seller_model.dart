class SellerModel {
  final String id;
  final String email;
  final String businessName;
  final String contactPersonName;
  final String phone;
  final String businessAddress;
  final String city;
  final String state;
  final String zipCode;
  final String businessType;
  final List<String> brandsCertifications;
  final String? businessLicense;
  final String? cosmeticLicense;
  final String? fdaRegistration;
  final String? taxId;
  final String? profileImage;

  SellerModel({
    required this.id,
    required this.email,
    required this.businessName,
    required this.contactPersonName,
    required this.phone,
    required this.businessAddress,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.businessType,
    required this.brandsCertifications,
    this.businessLicense,
    this.cosmeticLicense,
    this.fdaRegistration,
    this.taxId,
    this.profileImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'businessName': businessName,
      'contactPersonName': contactPersonName,
      'phone': phone,
      'businessAddress': businessAddress,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'businessType': businessType,
      'brandsCertifications': brandsCertifications,
      'businessLicense': businessLicense,
      'cosmeticLicense': cosmeticLicense,
      'fdaRegistration': fdaRegistration,
      'taxId': taxId,
      'profileImage': profileImage,
    };
  }

  factory SellerModel.fromJson(Map<String, dynamic> json) {
    return SellerModel(
      id: json['id'],
      email: json['email'],
      businessName: json['businessName'],
      contactPersonName: json['contactPersonName'],
      phone: json['phone'],
      businessAddress: json['businessAddress'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zipCode'],
      businessType: json['businessType'],
      brandsCertifications: List<String>.from(json['brandsCertifications'] ?? []),
      businessLicense: json['businessLicense'],
      cosmeticLicense: json['cosmeticLicense'],
      fdaRegistration: json['fdaRegistration'],
      taxId: json['taxId'],
      profileImage: json['profileImage'],
    );
  }
}