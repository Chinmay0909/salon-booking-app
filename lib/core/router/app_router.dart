import 'package:go_router/go_router.dart';
import '../../features/home/screens/home_screen.dart';

import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/auth/screens/user_type_selection_screen.dart';
import '../../features/auth/screens/user_login_screen.dart';
import '../../features/auth/screens/user_registration_screen.dart';
import '../../features/auth/screens/salon_login_screen.dart';
import '../../features/auth/screens/salon_registration_screen.dart';
import '../../features/auth/screens/seller_login_screen.dart';
import '../../features/auth/screens/seller_registration_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/auth',
    routes: [
      // Authentication Routes
      GoRoute(
        path: '/auth',
        builder: (context, state) => const UserTypeSelectionScreen(),
      ),

      // User Authentication
      GoRoute(
        path: '/auth/user/login',
        builder: (context, state) => const UserLoginScreen(),
      ),
      GoRoute(
        path: '/auth/user/register',
        builder: (context, state) => const UserRegistrationScreen(),
      ),

      // Salon Authentication
      GoRoute(
        path: '/auth/salon/login',
        builder: (context, state) => const SalonLoginScreen(),
      ),
      GoRoute(
        path: '/auth/salon/register',
        builder: (context, state) => const SalonRegistrationScreen(),
      ),

      // Seller Authentication
      GoRoute(
        path: '/auth/seller/login',
        builder: (context, state) => const SellerLoginScreen(),
      ),
      GoRoute(
        path: '/auth/seller/register',
        builder: (context, state) => const SellerRegistrationScreen(),
      ),

      // Main App Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),

    ],
  );
}