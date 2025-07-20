import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../utils/app_constants.dart';
import 'storage_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  User? _currentUser;
  final StreamController<User?> _userController = StreamController<User?>.broadcast();

  // Getters
  User? get currentUser => _currentUser;
  Stream<User?> get userStream => _userController.stream;
  bool get isAuthenticated => _currentUser != null;

  // Initialize auth service
  Future<void> initialize() async {
    try {
      final userData = await StorageService.getString(AppConstants.userDataKey);
      if (userData != null) {
        _currentUser = User.fromJson(jsonDecode(userData));
        _userController.add(_currentUser);
      }
    } catch (e) {
      debugPrint('Error initializing auth service: $e');
    }
  }

  // Check if user has completed onboarding
  static Future<bool> hasCompletedOnboarding() async {
    try {
      final completed = await StorageService.getBool(AppConstants.onboardingKey);
      return completed ?? false;
    } catch (e) {
      debugPrint('Error checking onboarding status: $e');
      return false;
    }
  }

  // Mark onboarding as completed
  static Future<void> completeOnboarding() async {
    try {
      await StorageService.setBool(AppConstants.onboardingKey, true);
    } catch (e) {
      debugPrint('Error marking onboarding complete: $e');
    }
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    try {
      final token = await StorageService.getString(AppConstants.userTokenKey);
      return token != null && token.isNotEmpty;
    } catch (e) {
      debugPrint('Error checking login status: $e');
      return false;
    }
  }

  // Login with email and password
  Future<AuthResult> login(String email, String password) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Validate credentials (replace with actual API call)
      if (_validateCredentials(email, password)) {
        final user = _getDemoUser(email);

        await _saveUserSession(user, 'fake_jwt_token_123');
        return AuthResult.success(user);
      } else {
        return AuthResult.error('Invalid email or password');
      }
    } catch (e) {
      debugPrint('Login error: $e');
      return AuthResult.error('Login failed. Please try again.');
    }
  }

  // Register new user
  Future<AuthResult> register({
    required String name,
    required String email,
    required String password,
    required UserType userType,
    String? phoneNumber,
    // Salon-specific fields
    String? businessName,
    String? businessLicense,
    List<String>? services,
    // Seller-specific fields
    String? companyName,
    String? taxId,
    List<String>? productCategories,
  }) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Check if email already exists (replace with actual API call)
      if (await _emailExists(email)) {
        return AuthResult.error('Email already exists');
      }

      final user = User(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        userType: userType,
        avatar: _getDefaultAvatar(userType),
        isPremium: userType != UserType.customer, // Salon and Sellers get premium by default
        createdAt: DateTime.now(),
        // Salon-specific data
        businessName: businessName,
        businessLicense: businessLicense,
        services: services,
        rating: userType == UserType.salon ? 4.5 : null,
        reviewCount: userType == UserType.salon ? 0 : null,
        // Seller-specific data
        companyName: companyName,
        taxId: taxId,
        productCategories: productCategories,
        isVerifiedSeller: userType == UserType.seller ? false : null,
      );

      await _saveUserSession(user, 'fake_jwt_token_${user.id}');
      return AuthResult.success(user);
    } catch (e) {
      debugPrint('Registration error: $e');
      return AuthResult.error('Registration failed. Please try again.');
    }
  }

  // Send password reset email
  Future<AuthResult> sendPasswordReset(String email) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Check if email exists (replace with actual API call)
      if (await _emailExists(email)) {
        return AuthResult.success(null, message: 'Password reset email sent');
      } else {
        return AuthResult.error('Email not found');
      }
    } catch (e) {
      debugPrint('Password reset error: $e');
      return AuthResult.error('Failed to send reset email. Please try again.');
    }
  }

  // Logout user
  Future<void> logout() async {
    try {
      await StorageService.remove(AppConstants.userTokenKey);
      await StorageService.remove(AppConstants.userDataKey);

      _currentUser = null;
      _userController.add(null);
    } catch (e) {
      debugPrint('Logout error: $e');
    }
  }

  // Update user profile
  Future<AuthResult> updateProfile(User updatedUser) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      _currentUser = updatedUser;
      await StorageService.setString(
        AppConstants.userDataKey,
        jsonEncode(updatedUser.toJson()),
      );

      _userController.add(_currentUser);
      return AuthResult.success(updatedUser, message: 'Profile updated successfully');
    } catch (e) {
      debugPrint('Profile update error: $e');
      return AuthResult.error('Failed to update profile. Please try again.');
    }
  }

  // Private helper methods
  Future<void> _saveUserSession(User user, String token) async {
    _currentUser = user;

    await StorageService.setString(AppConstants.userTokenKey, token);
    await StorageService.setString(
      AppConstants.userDataKey,
      jsonEncode(user.toJson()),
    );

    _userController.add(_currentUser);
  }

  bool _validateCredentials(String email, String password) {
    // Demo user credentials for different user types
    final demoCredentials = {
      'customer@demo.com': 'password123',
      'salon@demo.com': 'password123',
      'seller@demo.com': 'password123',
    };

    if (demoCredentials.containsKey(email) && demoCredentials[email] == password) {
      return true;
    }

    // Replace with actual validation logic
    return email.contains('@') && password.length >= 6;
  }

  User _getDemoUser(String email) {
    switch (email) {
      case 'customer@demo.com':
        return User(
          id: 'customer_demo',
          name: 'John Doe',
          email: email,
          userType: UserType.customer,
          phoneNumber: '+250 788 123 456',
          avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop&crop=face',
          isPremium: true,
          createdAt: DateTime.now().subtract(const Duration(days: 30)),
          address: '123 Main Street, Kigali, Rwanda',
          favoriteShops: ['1', '2'],
        );

      case 'salon@demo.com':
        return User(
          id: 'salon_demo',
          name: 'Sarah Wilson',
          email: email,
          userType: UserType.salon,
          phoneNumber: '+250 788 234 567',
          avatar: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=200&h=200&fit=crop&crop=face',
          isPremium: true,
          createdAt: DateTime.now().subtract(const Duration(days: 90)),
          businessName: 'Elite Beauty Salon',
          businessLicense: 'BL-2024-001',
          services: ['Haircut', 'Hair Styling', 'Hair Coloring', 'Facial', 'Manicure'],
          rating: 4.8,
          reviewCount: 127,
          address: 'KK 15 AVE Street, Kigali, RW',
          operatingHours: {
            'monday': {'open': '09:00', 'close': '18:00'},
            'tuesday': {'open': '09:00', 'close': '18:00'},
            'wednesday': {'open': '09:00', 'close': '18:00'},
            'thursday': {'open': '09:00', 'close': '18:00'},
            'friday': {'open': '09:00', 'close': '19:00'},
            'saturday': {'open': '08:00', 'close': '17:00'},
            'sunday': {'open': '10:00', 'close': '16:00'},
          },
        );

      case 'seller@demo.com':
        return User(
          id: 'seller_demo',
          name: 'Michael Chen',
          email: email,
          userType: UserType.seller,
          phoneNumber: '+250 788 345 678',
          avatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200&h=200&fit=crop&crop=face',
          isPremium: true,
          createdAt: DateTime.now().subtract(const Duration(days: 60)),
          companyName: 'Beauty Products Inc.',
          taxId: 'TAX-2024-567',
          productCategories: ['Hair Care', 'Skin Care', 'Makeup', 'Perfumes'],
          isVerifiedSeller: true,
          address: 'Industrial Zone, Kigali, RW',
        );

      default:
      // Default customer user for any other valid login
        return User(
          id: 'user_${DateTime.now().millisecondsSinceEpoch}',
          name: 'Demo User',
          email: email,
          userType: UserType.customer,
          phoneNumber: '+250 788 000 000',
          avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop&crop=face',
          isPremium: false,
          createdAt: DateTime.now(),
        );
    }
  }

  String _getDefaultAvatar(UserType userType) {
    switch (userType) {
      case UserType.customer:
        return 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop&crop=face';
      case UserType.salon:
        return 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=200&h=200&fit=crop&crop=face';
      case UserType.seller:
        return 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200&h=200&fit=crop&crop=face';
    }
  }

  Future<bool> _emailExists(String email) async {
    // Replace with actual API call
    return email == 'existing@email.com';
  }

  // Clean up
  void dispose() {
    _userController.close();
  }
}

// Auth result class
class AuthResult {
  final bool isSuccess;
  final User? user;
  final String? error;
  final String? message;

  AuthResult._({
    required this.isSuccess,
    this.user,
    this.error,
    this.message,
  });

  factory AuthResult.success(User? user, {String? message}) {
    return AuthResult._(
      isSuccess: true,
      user: user,
      message: message,
    );
  }

  factory AuthResult.error(String error) {
    return AuthResult._(
      isSuccess: false,
      error: error,
    );
  }
}