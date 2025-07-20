class AppConstants {
  // App Information
  static const String appName = 'Beauty Booking';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';

  // API Configuration
  static const String baseUrl = 'https://api.beautyBooking.com';
  static const String apiVersion = 'v1';
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds

  // Animation Durations
  static const Duration fastAnimation = Duration(milliseconds: 150);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);

  // UI Constants
  static const double defaultPadding = 20.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 32.0;
  static const double borderRadius = 12.0;
  static const double largeBorderRadius = 20.0;
  static const double cardElevation = 2.0;

  // Font Sizes
  static const double titleFontSize = 24.0;
  static const double headingFontSize = 18.0;
  static const double bodyFontSize = 16.0;
  static const double captionFontSize = 14.0;
  static const double smallFontSize = 12.0;
  static const double tinyFontSize = 10.0;

  // Icon Sizes
  static const double smallIconSize = 16.0;
  static const double normalIconSize = 24.0;
  static const double largeIconSize = 32.0;
  static const double extraLargeIconSize = 48.0;

  // Image Dimensions
  static const double avatarSize = 48.0;
  static const double smallAvatarSize = 32.0;
  static const double largeAvatarSize = 64.0;
  static const double bannerHeight = 180.0;
  static const double cardImageHeight = 160.0;

  // Service Categories
  static const List<String> serviceCategories = [
    'Haircuts',
    'Make up',
    'Manicure',
    'Massage',
    'Facial',
    'Eyebrows',
    'Nails',
    'Waxing',
  ];

  // Product Categories
  static const List<String> productCategories = [
    'Hair Care',
    'Skin Care',
    'Nail Care',
    'Body Care',
    'Makeup',
    'Perfumes',
    'Tools',
    'Accessories',
  ];

  // Time Slots
  static const List<String> timeSlots = [
    '09:00 AM',
    '09:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '12:00 PM',
    '12:30 PM',
    '01:00 PM',
    '01:30 PM',
    '02:00 PM',
    '02:30 PM',
    '03:00 PM',
    '03:30 PM',
    '04:00 PM',
    '04:30 PM',
    '05:00 PM',
    '05:30 PM',
    '06:00 PM',
  ];

  // Booking Status Colors
  static const Map<String, String> bookingStatusColors = {
    'upcoming': '#FF6B9D',
    'completed': '#4CAF50',
    'cancelled': '#F44336',
    'rescheduled': '#FF9800',
    'no_show': '#9E9E9E',
  };

  // Rating Configuration
  static const double minRating = 1.0;
  static const double maxRating = 5.0;
  static const int maxReviewLength = 500;

  // Search Configuration
  static const int minSearchLength = 2;
  static const int maxSearchResults = 50;
  static const Duration searchDelay = Duration(milliseconds: 500);

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Cache Configuration
  static const Duration cacheExpiration = Duration(hours: 24);
  static const int maxCacheSize = 100; // Number of items

  // File Upload
  static const int maxFileSize = 10 * 1024 * 1024; // 10 MB
  static const List<String> allowedImageFormats = ['jpg', 'jpeg', 'png', 'webp'];
  static const List<String> allowedVideoFormats = ['mp4', 'mov', 'avi'];
  static const List<String> allowedDocumentFormats = ['pdf', 'doc', 'docx'];

  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 50;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;
  static const int maxMessageLength = 1000;

  // Date & Time Formats
  static const String dateFormat = 'MMM dd, yyyy';
  static const String timeFormat = 'hh:mm a';
  static const String dateTimeFormat = 'MMM dd, yyyy - hh:mm a';
  static const String shortDateFormat = 'dd/MM/yyyy';

  // Error Messages
  static const String networkError = 'Network connection error. Please check your internet connection.';
  static const String serverError = 'Server error. Please try again later.';
  static const String unknownError = 'An unexpected error occurred. Please try again.';
  static const String validationError = 'Please check your input and try again.';

  // Success Messages
  static const String bookingConfirmed = 'Your booking has been confirmed successfully!';
  static const String bookingCancelled = 'Your booking has been cancelled.';
  static const String profileUpdated = 'Your profile has been updated successfully.';
  static const String messagesSent = 'Message sent successfully.';

  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String themeKey = 'app_theme';
  static const String languageKey = 'app_language';
  static const String onboardingKey = 'onboarding_completed';
  static const String notificationKey = 'notifications_enabled';

  // Deep Link Paths
  static const String homeRoute = '/home';
  static const String exploreRoute = '/explore';
  static const String productsRoute = '/products';
  static const String bookingsRoute = '/bookings';
  static const String messagesRoute = '/messages';
  static const String accountRoute = '/account';
  static const String shopDetailsRoute = '/shop';
  static const String productDetailsRoute = '/product';
  static const String bookingDetailsRoute = '/booking';

  // Feature Flags
  static const bool enableMessaging = true;
  static const bool enableProducts = true;
  static const bool enableNotifications = true;
  static const bool enableLocationServices = true;
  static const bool enableAnalytics = true;

  // Social Media Links
  static const String instagramUrl = 'https://instagram.com/beautyBooking';
  static const String facebookUrl = 'https://facebook.com/beautyBooking';
  static const String twitterUrl = 'https://twitter.com/beautyBooking';
  static const String linkedinUrl = 'https://linkedin.com/company/beautyBooking';

  // Support Information
  static const String supportEmail = 'support@beautyBooking.com';
  static const String supportPhone = '+1-234-567-8900';
  static const String privacyPolicyUrl = 'https://beautyBooking.com/privacy';
  static const String termsOfServiceUrl = 'https://beautyBooking.com/terms';
}