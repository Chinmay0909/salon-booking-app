import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/user.dart';
import 'app_colors.dart';
import '../services/auth_service.dart';

class AppHelpers {
  // Format time ago
  static String timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return years == 1 ? '1 year ago' : '$years years ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? '1 month ago' : '$months months ago';
    } else if (difference.inDays > 0) {
      return difference.inDays == 1 ? '1 day ago' : '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return difference.inHours == 1 ? '1 hour ago' : '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return difference.inMinutes == 1 ? '1 minute ago' : '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  // Format currency
  static String formatCurrency(double amount, {String symbol = '\$'}) {
    return '$symbol${amount.toStringAsFixed(2)}';
  }

  // Format phone number
  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6)}';
    }
    return phoneNumber;
  }

  // Validate email
  static bool isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  // Validate phone number
  static bool isValidPhoneNumber(String phone) {
    return RegExp(r'^\+?[\d\s\-\(\)]{10,}$').hasMatch(phone);
  }

  // Haptic feedback
  static void hapticFeedback({HapticFeedbackType type = HapticFeedbackType.light}) {
    switch (type) {
      case HapticFeedbackType.light:
        HapticFeedback.lightImpact();
        break;
      case HapticFeedbackType.medium:
        HapticFeedback.mediumImpact();
        break;
      case HapticFeedbackType.heavy:
        HapticFeedback.heavyImpact();
        break;
      case HapticFeedbackType.selection:
        HapticFeedback.selectionClick();
        break;
    }
  }

  // Show snackbar
  static void showSnackBar(
      BuildContext context,
      String message, {
        Color? backgroundColor,
        Duration duration = const Duration(seconds: 3),
        SnackBarAction? action,
      }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: backgroundColor ?? AppColors.primary,
        duration: duration,
        action: action,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  // Show loading dialog
  static void showLoadingDialog(BuildContext context, {String message = 'Loading...'}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Hide loading dialog
  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  // Show confirmation dialog
  static Future<bool> showConfirmationDialog(
      BuildContext context, {
        required String title,
        required String message,
        String confirmText = 'Confirm',
        String cancelText = 'Cancel',
        Color? confirmColor,
      }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            title,
            style: TextStyle(color: AppColors.textPrimary),
          ),
          content: Text(
            message,
            style: TextStyle(color: AppColors.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                cancelText,
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                confirmText,
                style: TextStyle(color: confirmColor ?? AppColors.primary),
              ),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  // Demo user login (for testing)
  static Future<void> loginDemoUser() async {
    final authService = AuthService();
    await authService.login('demo@beautyBooking.com', 'password123');
  }

  // Create demo user - FIXED VERSION
  static User createDemoUser({UserType userType = UserType.customer}) {
    return User(
      id: 'demo_user_${userType.toString().split('.').last}',
      name: _getDemoUserName(userType),
      email: 'demo@beautyBooking.com',
      phoneNumber: '+1 234 567 8900',
      avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop&crop=face',
      userType: userType, // ← This was missing and causing the error!
      isPremium: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
      preferences: {
        'notifications': true,
        'emailUpdates': true,
        'theme': 'dark',
      },
      favoriteShops: ['1', '2'],
      address: '123 Main Street, City, Country',
      dateOfBirth: DateTime(1990, 5, 15),
      gender: 'male',
      businessName: userType == UserType.seller ? 'Demo Business' : null,
      businessLicense: userType == UserType.seller ? 'DEMO123' : null,
      services: userType == UserType.salon
          ? ['Haircut', 'Styling', 'Color', 'Wash & Blow Dry'] : null,
      operatingHours: userType == UserType.salon
          ? {
        'monday': '9:00 AM - 6:00 PM',
        'tuesday': '9:00 AM - 6:00 PM',
        'wednesday': '9:00 AM - 6:00 PM',
        'thursday': '9:00 AM - 6:00 PM',
        'friday': '9:00 AM - 6:00 PM',
        'saturday': '10:00 AM - 4:00 PM',
        'sunday': 'Closed',
      } : null,
      rating: 4.5,
      reviewCount: 128,
      companyName: userType == UserType.seller ? 'Demo Company LLC' : null,
      taxId: userType == UserType.seller ? 'TAX123456' : null,
    );
  }

  // Helper method to get demo user name based on type
  static String _getDemoUserName(UserType userType) {
    switch (userType) {
      case UserType.customer:
        return 'Demo Customer';
      case UserType.seller:
        return 'Demo Seller';
      case UserType.salon:
        return 'Demo Salon Owner';
      default:
        return 'Demo User';
    }
  }

  // Additional helper methods to create specific demo users
  static User createDemoCustomer() {
    return createDemoUser(userType: UserType.customer);
  }

  static User createDemoSeller() {
    return createDemoUser(userType: UserType.seller);
  }

  static User createDemoSalon() {
    return createDemoUser(userType: UserType.salon);
  }

  // Generate gradient
  static Gradient createGradient(List<Color> colors, {
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
  }) {
    return LinearGradient(
      colors: colors,
      begin: begin,
      end: end,
    );
  }

  // Animate to page
  static void animateToPage(
      PageController controller,
      int page, {
        Duration duration = const Duration(milliseconds: 300),
        Curve curve = Curves.easeInOut,
      }) {
    controller.animateToPage(
      page,
      duration: duration,
      curve: curve,
    );
  }

  // Focus next field
  static void focusNextField(
      BuildContext context,
      FocusNode currentFocus,
      FocusNode nextFocus,
      ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  // Dismiss keyboard
  static void dismissKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  // Get greeting based on time
  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  // Calculate age
  static int calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  // Capitalize first letter
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  // Truncate text
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  // Color from string (for generating consistent colors from strings)
  static Color colorFromString(String input) {
    int hash = 0;
    for (int i = 0; i < input.length; i++) {
      hash = input.codeUnitAt(i) + ((hash << 5) - hash);
    }
    final color = Color((hash & 0xFFFFFF) | 0xFF000000);
    return color;
  }

  // Check if dark mode
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  // Get status bar height
  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).viewPadding.top;
  }

  // Get bottom padding (for safe area)
  static double getBottomPadding(BuildContext context) {
    return MediaQuery.of(context).viewPadding.bottom;
  }

  // Check if keyboard is visible
  static bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  // Get screen size
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  // Check if tablet
  static bool isTablet(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide >= 600;
  }

  // Helper method to determine user type based on business logic
  static UserType getUserTypeFromString(String userTypeString) {
    switch (userTypeString.toLowerCase()) {
      case 'customer':
        return UserType.customer;
      case 'seller':
        return UserType.seller;
      case 'salon':
        return UserType.salon;
      default:
        return UserType.customer; // Default fallback
    }
  }

  // Utility methods for user types
  static String getUserTypeDisplayName(UserType userType) {
    switch (userType) {
      case UserType.customer:
        return 'Customer';
      case UserType.seller:
        return 'Seller';
      case UserType.salon:
        return 'Salon';
      default:
        return 'Unknown';
    }
  }

  static Color getUserTypeColor(UserType userType) {
    switch (userType) {
      case UserType.customer:
        return Colors.blue;
      case UserType.seller:
        return Colors.green;
      case UserType.salon:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  static IconData getUserTypeIcon(UserType userType) {
    switch (userType) {
      case UserType.customer:
        return Icons.person;
      case UserType.seller:
        return Icons.store;
      case UserType.salon:
        return Icons.content_cut;
      default:
        return Icons.help;
    }
  }
}

enum HapticFeedbackType {
  light,
  medium,
  heavy,
  selection,
}