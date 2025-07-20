enum UserType {
  customer,
  salon,
  seller,
}

class User {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? avatar;
  final UserType userType;
  final bool isPremium;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final Map<String, dynamic>? preferences;
  final List<String>? favoriteShops;
  final String? address;
  final DateTime? dateOfBirth;
  final String? gender;

  // Salon-specific fields
  final String? businessName;
  final String? businessLicense;
  final List<String>? services;
  final Map<String, dynamic>? operatingHours;
  final double? rating;
  final int? reviewCount;

  // Seller-specific fields
  final String? companyName;
  final String? taxId;
  final List<String>? productCategories;
  final bool? isVerifiedSeller;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.avatar,
    required this.userType,
    this.isPremium = false,
    required this.createdAt,
    this.updatedAt,
    this.preferences,
    this.favoriteShops,
    this.address,
    this.dateOfBirth,
    this.gender,
    // Salon fields
    this.businessName,
    this.businessLicense,
    this.services,
    this.operatingHours,
    this.rating,
    this.reviewCount,
    // Seller fields
    this.companyName,
    this.taxId,
    this.productCategories,
    this.isVerifiedSeller,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      avatar: json['avatar'] as String?,
      userType: UserType.values.firstWhere(
            (e) => e.toString().split('.').last == json['userType'],
        orElse: () => UserType.customer,
      ),
      isPremium: json['isPremium'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      preferences: json['preferences'] as Map<String, dynamic>?,
      favoriteShops: json['favoriteShops'] != null
          ? List<String>.from(json['favoriteShops'])
          : null,
      address: json['address'] as String?,
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : null,
      gender: json['gender'] as String?,
      // Salon fields
      businessName: json['businessName'] as String?,
      businessLicense: json['businessLicense'] as String?,
      services: json['services'] != null
          ? List<String>.from(json['services'])
          : null,
      operatingHours: json['operatingHours'] as Map<String, dynamic>?,
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      reviewCount: json['reviewCount'] as int?,
      // Seller fields
      companyName: json['companyName'] as String?,
      taxId: json['taxId'] as String?,
      productCategories: json['productCategories'] != null
          ? List<String>.from(json['productCategories'])
          : null,
      isVerifiedSeller: json['isVerifiedSeller'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'avatar': avatar,
      'userType': userType.toString().split('.').last,
      'isPremium': isPremium,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'preferences': preferences,
      'favoriteShops': favoriteShops,
      'address': address,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      // Salon fields
      'businessName': businessName,
      'businessLicense': businessLicense,
      'services': services,
      'operatingHours': operatingHours,
      'rating': rating,
      'reviewCount': reviewCount,
      // Seller fields
      'companyName': companyName,
      'taxId': taxId,
      'productCategories': productCategories,
      'isVerifiedSeller': isVerifiedSeller,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? avatar,
    UserType? userType,
    bool? isPremium,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? preferences,
    List<String>? favoriteShops,
    String? address,
    DateTime? dateOfBirth,
    String? gender,
    String? businessName,
    String? businessLicense,
    List<String>? services,
    Map<String, dynamic>? operatingHours,
    double? rating,
    int? reviewCount,
    String? companyName,
    String? taxId,
    List<String>? productCategories,
    bool? isVerifiedSeller,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatar: avatar ?? this.avatar,
      userType: userType ?? this.userType,
      isPremium: isPremium ?? this.isPremium,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      preferences: preferences ?? this.preferences,
      favoriteShops: favoriteShops ?? this.favoriteShops,
      address: address ?? this.address,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      businessName: businessName ?? this.businessName,
      businessLicense: businessLicense ?? this.businessLicense,
      services: services ?? this.services,
      operatingHours: operatingHours ?? this.operatingHours,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      companyName: companyName ?? this.companyName,
      taxId: taxId ?? this.taxId,
      productCategories: productCategories ?? this.productCategories,
      isVerifiedSeller: isVerifiedSeller ?? this.isVerifiedSeller,
    );
  }

  // Helper getters
  String get firstName {
    return name.split(' ').first;
  }

  String get lastName {
    return name.split(' ').length > 1 ? name.split(' ').last : '';
  }

  String get initials {
    final names = name.split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    }
    return name.length >= 2 ? name.substring(0, 2).toUpperCase() : name.toUpperCase();
  }

  bool get hasAvatar => avatar != null && avatar!.isNotEmpty;

  String get membershipType => isPremium ? 'Premium Member' : 'Basic Member';

  String get userTypeDisplayName {
    switch (userType) {
      case UserType.customer:
        return 'Customer';
      case UserType.salon:
        return 'Salon Owner';
      case UserType.seller:
        return 'Product Seller';
    }
  }

  String get displayName {
    switch (userType) {
      case UserType.customer:
        return name;
      case UserType.salon:
        return businessName ?? name;
      case UserType.seller:
        return companyName ?? name;
    }
  }

  bool get isCustomer => userType == UserType.customer;
  bool get isSalon => userType == UserType.salon;
  bool get isSeller => userType == UserType.seller;

  int get accountAge {
    return DateTime.now().difference(createdAt).inDays;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, type: $userType)';
  }
}