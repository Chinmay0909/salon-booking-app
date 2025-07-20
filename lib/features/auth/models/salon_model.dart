class SalonModel {
  final String id;
  final String email;
  final String salonName;
  final String ownerName;
  final String phone;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final List<String> services;
  final String? businessLicense;
  final String? profileImage;

  SalonModel({
    required this.id,
    required this.email,
    required this.salonName,
    required this.ownerName,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.services,
    this.businessLicense,
    this.profileImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'salonName': salonName,
      'ownerName': ownerName,
      'phone': phone,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'services': services,
      'businessLicense': businessLicense,
      'profileImage': profileImage,
    };
  }

  factory SalonModel.fromJson(Map<String, dynamic> json) {
    return SalonModel(
      id: json['id'],
      email: json['email'],
      salonName: json['salonName'],
      ownerName: json['ownerName'],
      phone: json['phone'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zipCode'],
      services: List<String>.from(json['services']),
      businessLicense: json['businessLicense'],
      profileImage: json['profileImage'],
    );
  }
}