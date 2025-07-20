import '../models/shop.dart';
import '../models/product.dart';
import '../models/specialist.dart';
import '../models/booking.dart';
import '../models/message.dart';

class SampleData {
  // Sample Shops
  static List<Shop> get sampleShops => [
    const Shop(
      id: '1',
      name: 'Captains Barbershop',
      address: 'KK 15 AVE Street, Kigali, RW',
      distance: '1.2 km',
      rating: 4.8,
      imageUrl: 'https://images.unsplash.com/photo-1585747860715-2ba37e788b70?w=300&h=200&fit=crop',
      isFavorite: false,
      isOnline: true,
      services: ['Haircut', 'Beard Trim', 'Hair Styling', 'Hot Towel Shave'],
      phoneNumber: '+250 788 123 456',
      description: 'Premium barbershop offering traditional and modern haircuts with exceptional service.',
    ),
    const Shop(
      id: '2',
      name: 'Elite Hair Studio',
      address: 'KK 20 AVE Street, Kigali, RW',
      distance: '0.8 km',
      rating: 4.9,
      imageUrl: 'https://images.unsplash.com/photo-1562322140-8198e7b19f2f?w=300&h=200&fit=crop',
      isFavorite: true,
      isOnline: false,
      services: ['Hair Cut', 'Hair Coloring', 'Hair Styling', 'Treatment'],
      phoneNumber: '+250 788 234 567',
      description: 'Modern hair studio specializing in creative cuts and professional hair treatments.',
    ),
    const Shop(
      id: '3',
      name: 'Modern Cuts',
      address: 'KK 12 AVE Street, Kigali, RW',
      distance: '2.1 km',
      rating: 4.7,
      imageUrl: 'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?w=300&h=200&fit=crop',
      isFavorite: false,
      isOnline: true,
      services: ['Haircut', 'Styling', 'Coloring'],
      phoneNumber: '+250 788 345 678',
      description: 'Contemporary salon offering cutting-edge styles and premium hair care services.',
    ),
    const Shop(
      id: '4',
      name: 'Beauty Haven',
      address: 'KK 25 AVE Street, Kigali, RW',
      distance: '1.5 km',
      rating: 4.6,
      imageUrl: 'https://images.unsplash.com/photo-1560066984-138dadb4c035?w=300&h=200&fit=crop',
      isFavorite: false,
      isOnline: true,
      services: ['Facial', 'Massage', 'Manicure', 'Pedicure'],
      phoneNumber: '+250 788 456 789',
      description: 'Full-service beauty salon providing relaxation and rejuvenation treatments.',
    ),
  ];

  // Sample Products
  static List<Product> get sampleProducts => [
    const Product(
      id: '1',
      name: 'Hair Serum Premium',
      brand: 'Loreal Paris',
      description: 'Professional hair serum that provides intense nourishment and shine.',
      price: 45.99,
      originalPrice: 59.99,
      imageUrl: 'https://images.unsplash.com/photo-1556228453-efd6c1ff04f6?w=300&h=300&fit=crop',
      rating: 4.8,
      reviewCount: 124,
      category: 'Hair Care',
      tags: ['serum', 'nourishing', 'shine'],
      isOnSale: true,
      isFeatured: true,
      stockQuantity: 25,
    ),
    const Product(
      id: '2',
      name: 'Moisturizing Cream',
      brand: 'Nivea',
      description: 'Deep moisturizing cream for all skin types with 24-hour hydration.',
      price: 28.99,
      originalPrice: 35.99,
      imageUrl: 'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?w=300&h=300&fit=crop',
      rating: 4.6,
      reviewCount: 89,
      category: 'Skin Care',
      tags: ['moisturizer', 'hydrating', 'daily'],
      isOnSale: true,
      isFeatured: true,
      stockQuantity: 18,
    ),
    const Product(
      id: '3',
      name: 'Vitamin C Serum',
      brand: 'The Ordinary',
      description: 'Powerful vitamin C serum for brightening and anti-aging benefits.',
      price: 32.99,
      originalPrice: 42.99,
      imageUrl: 'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop',
      rating: 4.9,
      reviewCount: 156,
      category: 'Skin Care',
      tags: ['vitamin c', 'brightening', 'anti-aging'],
      isOnSale: true,
      isFeatured: true,
      stockQuantity: 32,
    ),
    const Product(
      id: '4',
      name: 'Hydrating Face Mask',
      brand: 'Cetaphil',
      description: 'Intensive hydrating face mask for dry and sensitive skin.',
      price: 24.99,
      originalPrice: 29.99,
      imageUrl: 'https://images.unsplash.com/photo-1612817288484-6f916006741a?w=300&h=300&fit=crop',
      rating: 4.7,
      reviewCount: 73,
      category: 'Skin Care',
      tags: ['face mask', 'hydrating', 'sensitive skin'],
      isOnSale: true,
      stockQuantity: 15,
    ),
    const Product(
      id: '5',
      name: 'Argan Oil Treatment',
      brand: 'Moroccan Oil',
      description: 'Pure argan oil treatment for hair nourishment and repair.',
      price: 38.99,
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300&h=300&fit=crop',
      rating: 4.8,
      reviewCount: 92,
      category: 'Hair Care',
      tags: ['argan oil', 'treatment', 'repair'],
      stockQuantity: 20,
    ),
    const Product(
      id: '6',
      name: 'Retinol Night Serum',
      brand: 'Olay',
      description: 'Advanced retinol night serum for fine lines and wrinkle reduction.',
      price: 42.99,
      imageUrl: 'https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?w=300&h=300&fit=crop',
      rating: 4.9,
      reviewCount: 134,
      category: 'Skin Care',
      tags: ['retinol', 'anti-aging', 'night care'],
      stockQuantity: 12,
    ),
  ];

  // Sample Specialists
  static List<Specialist> get sampleSpecialists => [
    const Specialist(
      id: '1',
      name: 'Tahir Osman',
      specialty: 'Hair Style',
      imageUrl: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=200&h=200&fit=crop&crop=face',
      isVerified: true,
      rating: 4.9,
      reviewCount: 87,
      shopId: '1',
      shopName: 'Captains Barbershop',
      services: ['Haircut', 'Styling', 'Beard Trim'],
      experienceYears: 8,
      bio: 'Expert hair stylist with 8 years of experience in modern and classic cuts.',
      isAvailable: true,
    ),
    const Specialist(
      id: '2',
      name: 'Sarah Johnson',
      specialty: 'Hair Style',
      imageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200&h=200&fit=crop&crop=face',
      isVerified: true,
      rating: 4.8,
      reviewCount: 73,
      shopId: '2',
      shopName: 'Elite Hair Studio',
      services: ['Hair Coloring', 'Styling', 'Treatment'],
      experienceYears: 6,
      bio: 'Creative hair artist specializing in color transformations and modern styles.',
      isAvailable: false,
    ),
    const Specialist(
      id: '3',
      name: 'Michael Chen',
      specialty: 'Hair Style',
      imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop&crop=face',
      isVerified: false,
      rating: 4.7,
      reviewCount: 65,
      shopId: '3',
      shopName: 'Modern Cuts',
      services: ['Haircut', 'Styling'],
      experienceYears: 5,
      bio: 'Professional barber with expertise in contemporary and traditional styles.',
      isAvailable: true,
    ),
  ];

  // Sample Bookings
  static List<Booking> get sampleBookings => [
    Booking(
      id: '1',
      userId: 'user123',
      shopId: '1',
      shopName: 'Captains Barbershop',
      specialistId: '1',
      specialistName: 'Tahir Osman',
      serviceName: 'Hair Cut & Styling',
      serviceDescription: 'Professional haircut with styling and beard trim',
      scheduledDateTime: DateTime.now().add(const Duration(hours: 4)),
      estimatedDuration: const Duration(minutes: 60),
      price: 35.00,
      status: BookingStatus.upcoming,
      notes: 'Please trim beard as well',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Booking(
      id: '2',
      userId: 'user123',
      shopId: '2',
      shopName: 'Elite Hair Studio',
      specialistId: '2',
      specialistName: 'Sarah Johnson',
      serviceName: 'Hair Coloring',
      serviceDescription: 'Professional hair coloring with premium products',
      scheduledDateTime: DateTime.now().add(const Duration(days: 3)),
      estimatedDuration: const Duration(minutes: 120),
      price: 85.00,
      status: BookingStatus.upcoming,
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    ),
    Booking(
      id: '3',
      userId: 'user123',
      shopId: '1',
      shopName: 'Captains Barbershop',
      specialistId: '1',
      specialistName: 'Tahir Osman',
      serviceName: 'Hair Cut & Beard Trim',
      serviceDescription: 'Classic haircut with beard styling',
      scheduledDateTime: DateTime.now().subtract(const Duration(days: 1)),
      estimatedDuration: const Duration(minutes: 45),
      price: 30.00,
      status: BookingStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Booking(
      id: '4',
      userId: 'user123',
      shopId: '3',
      shopName: 'Modern Cuts',
      serviceName: 'Hair Cut',
      serviceDescription: 'Modern style haircut',
      scheduledDateTime: DateTime.now().subtract(const Duration(days: 3)),
      estimatedDuration: const Duration(minutes: 30),
      price: 25.00,
      status: BookingStatus.cancelled,
      cancellationReason: 'Schedule conflict',
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
    ),
  ];

  // Sample Conversations
  static List<Conversation> get sampleConversations => [
    Conversation(
      id: '1',
      name: 'Captains Barbershop',
      avatar: 'https://images.unsplash.com/photo-1585747860715-2ba37e788b70?w=100&h=100&fit=crop',
      lastMessage: Message(
        id: 'msg1',
        conversationId: '1',
        senderId: 'shop1',
        content: 'Your appointment is confirmed for tomorrow at 2:30 PM',
        timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
        isFromCurrentUser: false,
      ),
      unreadCount: 2,
      isOnline: true,
      participantIds: ['user123', 'shop1'],
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
    Conversation(
      id: '2',
      name: 'Elite Hair Studio',
      avatar: 'https://images.unsplash.com/photo-1562322140-8198e7b19f2f?w=100&h=100&fit=crop',
      lastMessage: Message(
        id: 'msg2',
        conversationId: '2',
        senderId: 'shop2',
        content: 'Thank you for choosing our services!',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        isFromCurrentUser: false,
      ),
      unreadCount: 0,
      isOnline: false,
      participantIds: ['user123', 'shop2'],
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    Conversation(
      id: '3',
      name: 'Modern Cuts',
      avatar: 'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?w=100&h=100&fit=crop',
      lastMessage: Message(
        id: 'msg3',
        conversationId: '3',
        senderId: 'shop3',
        content: 'We have a special offer for you this week',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        isFromCurrentUser: false,
      ),
      unreadCount: 1,
      isOnline: true,
      participantIds: ['user123', 'shop3'],
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    Conversation(
      id: '4',
      name: 'Beauty Haven',
      avatar: 'https://images.unsplash.com/photo-1560066984-138dadb4c035?w=100&h=100&fit=crop',
      lastMessage: Message(
        id: 'msg4',
        conversationId: '4',
        senderId: 'shop4',
        content: 'Your feedback helps us improve our services',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isFromCurrentUser: false,
      ),
      unreadCount: 0,
      isOnline: false,
      participantIds: ['user123', 'shop4'],
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  // Sample Messages for a conversation
  static List<Message> getSampleMessages(String conversationId) {
    return [
      Message(
        id: 'msg_${conversationId}_1',
        conversationId: conversationId,
        senderId: 'user123',
        content: 'Hi, I would like to book an appointment for tomorrow',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isFromCurrentUser: true,
        status: MessageStatus.read,
      ),
      Message(
        id: 'msg_${conversationId}_2',
        conversationId: conversationId,
        senderId: 'shop_$conversationId',
        content: 'Hello! We have availability at 2:30 PM tomorrow. Would that work for you?',
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 55)),
        isFromCurrentUser: false,
        status: MessageStatus.delivered,
      ),
      Message(
        id: 'msg_${conversationId}_3',
        conversationId: conversationId,
        senderId: 'user123',
        content: 'Perfect! Please book me for 2:30 PM',
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 50)),
        isFromCurrentUser: true,
        status: MessageStatus.read,
      ),
      Message(
        id: 'msg_${conversationId}_4',
        conversationId: conversationId,
        senderId: 'shop_$conversationId',
        content: 'Great! Your appointment is confirmed for tomorrow at 2:30 PM. We look forward to seeing you!',
        timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
        isFromCurrentUser: false,
        status: MessageStatus.delivered,
      ),
    ];
  }

  // Helper method to get featured products
  static List<Product> get featuredProducts =>
      sampleProducts.where((product) => product.isFeatured).toList();

  // Helper method to get products on sale
  static List<Product> get saleProducts =>
      sampleProducts.where((product) => product.isOnSale).toList();

  // Helper method to get verified specialists
  static List<Specialist> get verifiedSpecialists =>
      sampleSpecialists.where((specialist) => specialist.isVerified).toList();

  // Helper method to get favorite shops
  static List<Shop> get favoriteShops =>
      sampleShops.where((shop) => shop.isFavorite).toList();

  // Helper method to get upcoming bookings
  static List<Booking> get upcomingBookings =>
      sampleBookings.where((booking) => booking.status == BookingStatus.upcoming).toList();

  // Helper method to get completed bookings
  static List<Booking> get completedBookings =>
      sampleBookings.where((booking) => booking.status == BookingStatus.completed).toList();

  // Helper method to get cancelled bookings
  static List<Booking> get cancelledBookings =>
      sampleBookings.where((booking) => booking.status == BookingStatus.cancelled).toList();
}