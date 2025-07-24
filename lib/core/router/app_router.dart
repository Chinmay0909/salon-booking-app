import 'package:go_router/go_router.dart';
import '../../screens/home_screen.dart';

import '../../screens/auth/auth_wrapper.dart';
import '../../screens/auth/user_type_selection_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/register_screen.dart';
import '../../screens/auth/forgot_password_screen.dart';
import '../../screens/auth/onboarding_screen.dart';
import '../../models/user.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/auth',
    routes: [
      // Authentication Routes
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthWrapper(),
      ),

      // Onboarding
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => OnboardingScreen(
          onCompleted: () {
            // Handle onboarding completion
          },
        ),
      ),

      // User Type Selection
      GoRoute(
        path: '/auth/user-type',
        builder: (context, state) => const UserTypeSelectionScreen(),
      ),

      // Login
      GoRoute(
        path: '/auth/login',
        builder: (context, state) => LoginScreen(
          onLoginSuccess: () {
            // Handle login success - navigate to main app
          },
        ),
      ),

      // Register with user type parameter
      GoRoute(
        path: '/auth/register/:userType',
        builder: (context, state) {
          final userTypeString = state.pathParameters['userType']!;
          UserType userType;

          switch (userTypeString) {
            case 'customer':
              userType = UserType.customer;
              break;
            case 'salon':
              userType = UserType.salon;
              break;
            case 'seller':
              userType = UserType.seller;
              break;
            default:
              userType = UserType.customer;
          }

          return RegisterScreen(
            userType: userType,
            onRegisterSuccess: () {
              // Handle registration success
            },
          );
        },
      ),

      // Forgot Password
      GoRoute(
        path: '/auth/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // Main App Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),

    ],
  );
}