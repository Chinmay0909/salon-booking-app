import 'package:flutter/material.dart';

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
  final Map<String, ScheduleModel> schedule;
  final List<ReviewModel> reviews;
  final List<String> galleryImages;

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
  });

  // Factory constructor for creating sample data
  factory SalonModel.sample() {
    return SalonModel(
      id: '1',
      name: 'Captains Barbershop',
      address: 'KK 15 AVE, Kicukiro, Kigali, RW',
      rating: 4.8,
      reviewCount: 6374,
      distance: 1.2,
      isOpen: true,
      imageUrl: 'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?w=500',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sagittis iaculis scelerisque. Fusce pulvinar interdum t...',
      specialists: SpecialistModel.sampleList(),
      services: ServiceModel.sampleList(),
      schedule: ScheduleModel.sampleSchedule(),
      reviews: ReviewModel.sampleList(),
      galleryImages: [
        'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?w=300',
        'https://images.unsplash.com/photo-1560066984-138dadb4c035?w=300',
        'https://images.unsplash.com/photo-1521490878405-2fc188d189b4?w=300',
        'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300',
        'https://images.unsplash.com/photo-1622286342621-4bd786c2447c?w=300',
        'https://images.unsplash.com/photo-1559599101-f09722fb4948?w=300',
      ],
    );
  }
}

class SpecialistModel {
  final String id;
  final String name;
  final String specialty;
  final String imageUrl;
  final bool isVerified;

  SpecialistModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.isVerified,
  });

  static List<SpecialistModel> sampleList() {
    return [
      SpecialistModel(
        id: '1',
        name: 'Tahir osman',
        specialty: 'Hair Style',
        imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
        isVerified: true,
      ),
      SpecialistModel(
        id: '2',
        name: 'Tahir osman',
        specialty: 'Hair Style',
        imageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100',
        isVerified: true,
      ),
    ];
  }
}

class ServiceModel {
  final String id;
  final String name;
  final String imageUrl;

  ServiceModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  static List<ServiceModel> sampleList() {
    return [
      ServiceModel(
        id: '1',
        name: 'Hair Cut',
        imageUrl: 'https://images.unsplash.com/photo-1605497788044-5a32c7078486?w=100',
      ),
      ServiceModel(
        id: '2',
        name: 'Hair Coloring',
        imageUrl: 'https://images.unsplash.com/photo-1562322140-8baeececf3df?w=100',
      ),
      ServiceModel(
        id: '3',
        name: 'Hair Wash',
        imageUrl: 'https://images.unsplash.com/photo-1559599101-f09722fb4948?w=100',
      ),
      ServiceModel(
        id: '4',
        name: 'Shaving',
        imageUrl: 'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?w=100',
      ),
      ServiceModel(
        id: '5',
        name: 'Skin Care',
        imageUrl: 'https://images.unsplash.com/photo-1616683693504-3ea7e9ad6fec?w=100',
      ),
      ServiceModel(
        id: '6',
        name: 'Hair Dryer',
        imageUrl: 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=100',
      ),
      ServiceModel(
        id: '7',
        name: 'Face Makeup',
        imageUrl: 'https://images.unsplash.com/photo-1487412912498-0447578fcca8?w=100',
      ),
    ];
  }
}

class ScheduleModel {
  final String startTime;
  final String endTime;
  final bool isOpen;

  ScheduleModel({
    required this.startTime,
    required this.endTime,
    required this.isOpen,
  });

  static Map<String, ScheduleModel> sampleSchedule() {
    return {
      'Monday': ScheduleModel(startTime: '9:00 AM', endTime: '6:00 PM', isOpen: true),
      'Tuesday': ScheduleModel(startTime: '8:00 AM', endTime: '6:00 PM', isOpen: true),
      'Wednesday': ScheduleModel(startTime: '', endTime: '', isOpen: false),
      'Thursday': ScheduleModel(startTime: '8:00 AM', endTime: '6:00 PM', isOpen: true),
      'Friday': ScheduleModel(startTime: '8:00 AM', endTime: '6:00 PM', isOpen: true),
      'Saturday': ScheduleModel(startTime: '9:00 AM', endTime: '5:00 PM', isOpen: true),
      'Sunday': ScheduleModel(startTime: '', endTime: '', isOpen: false),
    };
  }
}

class ReviewModel {
  final String id;
  final String customerName;
  final String customerImage;
  final double rating;
  final String timeAgo;
  final String comment;
  final List<String> tags;
  final int helpfulCount;

  ReviewModel({
    required this.id,
    required this.customerName,
    required this.customerImage,
    required this.rating,
    required this.timeAgo,
    required this.comment,
    required this.tags,
    required this.helpfulCount,
  });

  static List<ReviewModel> sampleList() {
    return [
      ReviewModel(
        id: '1',
        customerName: 'Annette Black',
        customerImage: 'https://images.unsplash.com/photo-1494790108755-2616b332e886?w=100',
        rating: 4.5,
        timeAgo: '2 hours ago',
        comment: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum luctus in felis ut fringilla. Integer dapibus, nisl sed effend fintibus.',
        tags: ['Worth the price', 'Met expectations', 'Fast'],
        helpfulCount: 2678,
      ),
      ReviewModel(
        id: '2',
        customerName: 'Annette Black',
        customerImage: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
        rating: 4.5,
        timeAgo: '2 hours ago',
        comment: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum luctus in felis ut fringilla. Integer dapibus, nisl sed effend fintibus.',
        tags: ['Worth the price', 'Met expectations', 'Fast'],
        helpfulCount: 2678,
      ),
      ReviewModel(
        id: '3',
        customerName: 'Annette Black',
        customerImage: 'https://images.unsplash.com/photo-1489424731084-a5d8b219a5bb?w=100',
        rating: 4.5,
        timeAgo: '2 hours ago',
        comment: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum luctus in felis ut fringilla. Integer dapibus, nisl sed effend fintibus.',
        tags: ['Worth the price', 'Met expectations', 'Fast'],
        helpfulCount: 2678,
      ),
    ];
  }
}