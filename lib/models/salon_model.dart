// models/salon_model.dart

class SalonModel {
  final String id;
  final String name;
  final String address;
  final double rating;
  final int reviewCount;
  final double distance;
  final bool isOpen;
  final String imageUrl;
  final String description;
  final List<SpecialistModel> specialists;
  final List<ServiceModel> services;
  final ScheduleModel schedule;
  final List<ReviewModel> reviews;
  final List<String> galleryImages;
  bool? isFavorite;

  SalonModel({
    required this.id,
    required this.name,
    required this.address,
    required this.rating,
    required this.reviewCount,
    required this.distance,
    required this.isOpen,
    required this.imageUrl,
    required this.description,
    required this.specialists,
    required this.services,
    required this.schedule,
    required this.reviews,
    required this.galleryImages,
    this.isFavorite = false,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'rating': rating,
      'reviewCount': reviewCount,
      'distance': distance,
      'isOpen': isOpen,
      'imageUrl': imageUrl,
      'description': description,
      'specialists': specialists.map((s) => s.toJson()).toList(),
      'services': services.map((s) => s.toJson()).toList(),
      'schedule': schedule.toJson(),
      'reviews': reviews.map((r) => r.toJson()).toList(),
      'galleryImages': galleryImages,
      'isFavorite': isFavorite,
    };
  }

  // Create from JSON
  factory SalonModel.fromJson(Map<String, dynamic> json) {
    return SalonModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      rating: json['rating'].toDouble(),
      reviewCount: json['reviewCount'],
      distance: json['distance'].toDouble(),
      isOpen: json['isOpen'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      specialists: (json['specialists'] as List)
          .map((s) => SpecialistModel.fromJson(s))
          .toList(),
      services: (json['services'] as List)
          .map((s) => ServiceModel.fromJson(s))
          .toList(),
      schedule: ScheduleModel.fromJson(json['schedule']),
      reviews: (json['reviews'] as List)
          .map((r) => ReviewModel.fromJson(r))
          .toList(),
      galleryImages: List<String>.from(json['galleryImages']),
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  // Copy with method for updating properties
  SalonModel copyWith({
    String? id,
    String? name,
    String? address,
    double? rating,
    int? reviewCount,
    double? distance,
    bool? isOpen,
    String? imageUrl,
    String? description,
    List<SpecialistModel>? specialists,
    List<ServiceModel>? services,
    ScheduleModel? schedule,
    List<ReviewModel>? reviews,
    List<String>? galleryImages,
    bool? isFavorite,
  }) {
    return SalonModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      distance: distance ?? this.distance,
      isOpen: isOpen ?? this.isOpen,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      specialists: specialists ?? this.specialists,
      services: services ?? this.services,
      schedule: schedule ?? this.schedule,
      reviews: reviews ?? this.reviews,
      galleryImages: galleryImages ?? this.galleryImages,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class SpecialistModel {
  final String id;
  final String name;
  final String specialty;
  final String imageUrl;
  final bool isVerified;
  final double rating;
  final int reviewCount;
  final int experience;
  final String? salonId;
  final List<String>? services;

  SpecialistModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.imageUrl,
    this.isVerified = false,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.experience = 0,
    this.salonId,
    this.services,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'imageUrl': imageUrl,
      'isVerified': isVerified,
      'rating': rating,
      'reviewCount': reviewCount,
      'experience': experience,
      'salonId': salonId,
      'services': services,
    };
  }

  factory SpecialistModel.fromJson(Map<String, dynamic> json) {
    return SpecialistModel(
      id: json['id'],
      name: json['name'],
      specialty: json['specialty'],
      imageUrl: json['imageUrl'],
      isVerified: json['isVerified'] ?? false,
      rating: json['rating']?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] ?? 0,
      experience: json['experience'] ?? 0,
      salonId: json['salonId'],
      services: json['services'] != null
          ? List<String>.from(json['services'])
          : null,
    );
  }

  static List<SpecialistModel> sampleList() {
    return [
      SpecialistModel(
        id: 'spec_1',
        name: 'John Smith',
        specialty: 'Hair Stylist',
        imageUrl: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=200',
        isVerified: true,
        rating: 4.8,
        reviewCount: 156,
        experience: 8,
        services: ['Hair Cut', 'Hair Wash', 'Styling'],
      ),
      SpecialistModel(
        id: 'spec_2',
        name: 'Mike Johnson',
        specialty: 'Barber',
        imageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200',
        isVerified: true,
        rating: 4.9,
        reviewCount: 203,
        experience: 12,
        services: ['Hair Cut', 'Beard Trim', 'Shave'],
      ),
    ];
  }
}

class ServiceModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final int duration; // in minutes
  final String? imageUrl;

  ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'duration': duration,
      'imageUrl': imageUrl,
    };
  }

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      duration: json['duration'],
      imageUrl: json['imageUrl'],
    );
  }

  static List<ServiceModel> sampleList() {
    return [
      ServiceModel(
        id: 'service_1',
        name: 'Hair Cut',
        description: 'Professional hair cutting service',
        price: 25.0,
        duration: 30,
      ),
      ServiceModel(
        id: 'service_2',
        name: 'Beard Trim',
        description: 'Professional beard trimming and styling',
        price: 15.0,
        duration: 20,
      ),
      ServiceModel(
        id: 'service_3',
        name: 'Hair Wash',
        description: 'Hair washing with premium products',
        price: 10.0,
        duration: 15,
      ),
    ];
  }
}

class ScheduleModel {
  final Map<String, OpeningHours> weeklySchedule;

  ScheduleModel({required this.weeklySchedule});

  Map<String, dynamic> toJson() {
    return {
      'weeklySchedule': weeklySchedule.map(
            (key, value) => MapEntry(key, value.toJson()),
      ),
    };
  }

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      weeklySchedule: (json['weeklySchedule'] as Map<String, dynamic>).map(
            (key, value) => MapEntry(key, OpeningHours.fromJson(value)),
      ),
    );
  }

  static ScheduleModel sampleSchedule() {
    return ScheduleModel(
      weeklySchedule: {
        'Monday': OpeningHours(openTime: '09:00', closeTime: '18:00'),
        'Tuesday': OpeningHours(openTime: '09:00', closeTime: '18:00'),
        'Wednesday': OpeningHours(openTime: '09:00', closeTime: '18:00'),
        'Thursday': OpeningHours(openTime: '09:00', closeTime: '18:00'),
        'Friday': OpeningHours(openTime: '09:00', closeTime: '18:00'),
        'Saturday': OpeningHours(openTime: '10:00', closeTime: '16:00'),
        'Sunday': OpeningHours(isClosed: true),
      },
    );
  }
}

class OpeningHours {
  final String? openTime;
  final String? closeTime;
  final bool isClosed;

  OpeningHours({
    this.openTime,
    this.closeTime,
    this.isClosed = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'openTime': openTime,
      'closeTime': closeTime,
      'isClosed': isClosed,
    };
  }

  factory OpeningHours.fromJson(Map<String, dynamic> json) {
    return OpeningHours(
      openTime: json['openTime'],
      closeTime: json['closeTime'],
      isClosed: json['isClosed'] ?? false,
    );
  }
}

class ReviewModel {
  final String id;
  final String customerName;
  final String customerImageUrl;
  final double rating;
  final String comment;
  final DateTime date;

  ReviewModel({
    required this.id,
    required this.customerName,
    required this.customerImageUrl,
    required this.rating,
    required this.comment,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerName': customerName,
      'customerImageUrl': customerImageUrl,
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(),
    };
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      customerName: json['customerName'],
      customerImageUrl: json['customerImageUrl'],
      rating: json['rating'].toDouble(),
      comment: json['comment'],
      date: DateTime.parse(json['date']),
    );
  }

  static List<ReviewModel> sampleList() {
    return [
      ReviewModel(
        id: 'review_1',
        customerName: 'Sarah Johnson',
        customerImageUrl: 'https://images.unsplash.com/photo-1494790108755-2616b5d62f7b?w=100',
        rating: 5.0,
        comment: 'Excellent service! Very professional and friendly staff.',
        date: DateTime.now().subtract(const Duration(days: 5)),
      ),
      ReviewModel(
        id: 'review_2',
        customerName: 'David Brown',
        customerImageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
        rating: 4.0,
        comment: 'Good haircut, will come again.',
        date: DateTime.now().subtract(const Duration(days: 12)),
      ),
    ];
  }
}