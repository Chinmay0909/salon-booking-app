class Specialist {
  final String id;
  final String name;
  final String specialty;
  final String imageUrl;
  final bool isVerified;
  final double rating;
  final int reviewCount;
  final String? shopId;
  final String? shopName;
  final List<String> services;
  final String? bio;
  final int experienceYears;
  final List<String>? certifications;
  final List<String>? gallery;
  final bool isAvailable;
  final DateTime? nextAvailableSlot;

  const Specialist({
    required this.id,
    required this.name,
    required this.specialty,
    required this.imageUrl,
    this.isVerified = false,
    required this.rating,
    required this.reviewCount,
    this.shopId,
    this.shopName,
    this.services = const [],
    this.bio,
    required this.experienceYears,
    this.certifications,
    this.gallery,
    this.isAvailable = true,
    this.nextAvailableSlot,
  });

  factory Specialist.fromJson(Map<String, dynamic> json) {
    return Specialist(
      id: json['id'] as String,
      name: json['name'] as String,
      specialty: json['specialty'] as String,
      imageUrl: json['imageUrl'] as String,
      isVerified: json['isVerified'] as bool? ?? false,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      shopId: json['shopId'] as String?,
      shopName: json['shopName'] as String?,
      services: List<String>.from(json['services'] as List? ?? []),
      bio: json['bio'] as String?,
      experienceYears: json['experienceYears'] as int,
      certifications: json['certifications'] != null
          ? List<String>.from(json['certifications'])
          : null,
      gallery: json['gallery'] != null
          ? List<String>.from(json['gallery'])
          : null,
      isAvailable: json['isAvailable'] as bool? ?? true,
      nextAvailableSlot: json['nextAvailableSlot'] != null
          ? DateTime.parse(json['nextAvailableSlot'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'imageUrl': imageUrl,
      'isVerified': isVerified,
      'rating': rating,
      'reviewCount': reviewCount,
      'shopId': shopId,
      'shopName': shopName,
      'services': services,
      'bio': bio,
      'experienceYears': experienceYears,
      'certifications': certifications,
      'gallery': gallery,
      'isAvailable': isAvailable,
      'nextAvailableSlot': nextAvailableSlot?.toIso8601String(),
    };
  }

  Specialist copyWith({
    String? id,
    String? name,
    String? specialty,
    String? imageUrl,
    bool? isVerified,
    double? rating,
    int? reviewCount,
    String? shopId,
    String? shopName,
    List<String>? services,
    String? bio,
    int? experienceYears,
    List<String>? certifications,
    List<String>? gallery,
    bool? isAvailable,
    DateTime? nextAvailableSlot,
  }) {
    return Specialist(
      id: id ?? this.id,
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      imageUrl: imageUrl ?? this.imageUrl,
      isVerified: isVerified ?? this.isVerified,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      shopId: shopId ?? this.shopId,
      shopName: shopName ?? this.shopName,
      services: services ?? this.services,
      bio: bio ?? this.bio,
      experienceYears: experienceYears ?? this.experienceYears,
      certifications: certifications ?? this.certifications,
      gallery: gallery ?? this.gallery,
      isAvailable: isAvailable ?? this.isAvailable,
      nextAvailableSlot: nextAvailableSlot ?? this.nextAvailableSlot,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Specialist && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Specialist(id: $id, name: $name, specialty: $specialty)';
  }
}