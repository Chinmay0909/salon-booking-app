class Product {
  final String id;
  final String name;
  final String brand;
  final String description;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final List<String>? gallery;
  final double rating;
  final int reviewCount;
  final String category;
  final List<String> tags;
  final bool isOnSale;
  final bool isFeatured;
  final bool isFavorite;
  final int stockQuantity;
  final Map<String, String>? attributes; // size, color, etc.
  final DateTime? saleEndDate;

  const Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    this.gallery,
    required this.rating,
    required this.reviewCount,
    required this.category,
    this.tags = const [],
    this.isOnSale = false,
    this.isFeatured = false,
    this.isFavorite = false,
    required this.stockQuantity,
    this.attributes,
    this.saleEndDate,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      brand: json['brand'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      originalPrice: json['originalPrice'] != null
          ? (json['originalPrice'] as num).toDouble()
          : null,
      imageUrl: json['imageUrl'] as String,
      gallery: json['gallery'] != null
          ? List<String>.from(json['gallery'])
          : null,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      category: json['category'] as String,
      tags: List<String>.from(json['tags'] as List? ?? []),
      isOnSale: json['isOnSale'] as bool? ?? false,
      isFeatured: json['isFeatured'] as bool? ?? false,
      isFavorite: json['isFavorite'] as bool? ?? false,
      stockQuantity: json['stockQuantity'] as int,
      attributes: json['attributes'] != null
          ? Map<String, String>.from(json['attributes'])
          : null,
      saleEndDate: json['saleEndDate'] != null
          ? DateTime.parse(json['saleEndDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'description': description,
      'price': price,
      'originalPrice': originalPrice,
      'imageUrl': imageUrl,
      'gallery': gallery,
      'rating': rating,
      'reviewCount': reviewCount,
      'category': category,
      'tags': tags,
      'isOnSale': isOnSale,
      'isFeatured': isFeatured,
      'isFavorite': isFavorite,
      'stockQuantity': stockQuantity,
      'attributes': attributes,
      'saleEndDate': saleEndDate?.toIso8601String(),
    };
  }

  Product copyWith({
    String? id,
    String? name,
    String? brand,
    String? description,
    double? price,
    double? originalPrice,
    String? imageUrl,
    List<String>? gallery,
    double? rating,
    int? reviewCount,
    String? category,
    List<String>? tags,
    bool? isOnSale,
    bool? isFeatured,
    bool? isFavorite,
    int? stockQuantity,
    Map<String, String>? attributes,
    DateTime? saleEndDate,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      description: description ?? this.description,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      imageUrl: imageUrl ?? this.imageUrl,
      gallery: gallery ?? this.gallery,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      isOnSale: isOnSale ?? this.isOnSale,
      isFeatured: isFeatured ?? this.isFeatured,
      isFavorite: isFavorite ?? this.isFavorite,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      attributes: attributes ?? this.attributes,
      saleEndDate: saleEndDate ?? this.saleEndDate,
    );
  }

  // Helper getters
  double? get discountPercentage {
    if (originalPrice == null || originalPrice! <= price) return null;
    return ((originalPrice! - price) / originalPrice! * 100);
  }

  bool get isInStock => stockQuantity > 0;

  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: \$$price)';
  }
}