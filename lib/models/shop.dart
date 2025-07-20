class Shop {
  final String id;
  final String name;
  final String address;
  final String distance;
  final double rating;
  final String imageUrl;
  final bool isFavorite;
  final bool isOnline;
  final List<String> services;
  final double? latitude;
  final double? longitude;
  final String? phoneNumber;
  final String? description;
  final List<String>? gallery;
  final Map<String, dynamic>? operatingHours;

  const Shop({
    required this.id,
    required this.name,
    required this.address,
    required this.distance,
    required this.rating,
    required this.imageUrl,
    this.isFavorite = false,
    this.isOnline = false,
    this.services = const [],
    this.latitude,
    this.longitude,
    this.phoneNumber,
    this.description,
    this.gallery,
    this.operatingHours,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      distance: json['distance'] as String,
      rating: (json['rating'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
      isOnline: json['isOnline'] as bool? ?? false,
      services: List<String>.from(json['services'] as List? ?? []),
      latitude: json['latitude'] as double?,
      longitude: json['longitude'] as double?,
      phoneNumber: json['phoneNumber'] as String?,
      description: json['description'] as String?,
      gallery: json['gallery'] != null ? List<String>.from(json['gallery']) : null,
      operatingHours: json['operatingHours'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'distance': distance,
      'rating': rating,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
      'isOnline': isOnline,
      'services': services,
      'latitude': latitude,
      'longitude': longitude,
      'phoneNumber': phoneNumber,
      'description': description,
      'gallery': gallery,
      'operatingHours': operatingHours,
    };
  }

  Shop copyWith({
    String? id,
    String? name,
    String? address,
    String? distance,
    double? rating,
    String? imageUrl,
    bool? isFavorite,
    bool? isOnline,
    List<String>? services,
    double? latitude,
    double? longitude,
    String? phoneNumber,
    String? description,
    List<String>? gallery,
    Map<String, dynamic>? operatingHours,
  }) {
    return Shop(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      distance: distance ?? this.distance,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      isOnline: isOnline ?? this.isOnline,
      services: services ?? this.services,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      description: description ?? this.description,
      gallery: gallery ?? this.gallery,
      operatingHours: operatingHours ?? this.operatingHours,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Shop && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Shop(id: $id, name: $name, rating: $rating)';
  }
}