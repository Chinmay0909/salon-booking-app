import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';
import 'explore_screen.dart';
import 'products_screen.dart';
import 'bookings_screen.dart';
import 'messages_screen.dart';
import 'account_screen.dart';
import 'salon/salon_dashboard_screen.dart';
import 'salon/salon_bookings_screen.dart';
import 'salon/salon_services_screen.dart';
import 'seller/seller_dashboard_screen.dart';
import 'seller/seller_products_screen.dart';
import 'seller/seller_orders_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        final user = AuthService().currentUser;

        if (user == null) {
          return const Scaffold(
            backgroundColor: AppColors.background,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Get navigation items and screens based on user type
        final navigationData = _getNavigationData(user.userType);

        return Scaffold(
          body: navigationData['screens'][_currentIndex],
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(
                top: BorderSide(
                  color: AppColors.cardBackground,
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.surface,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.textSecondary,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              elevation: 0,
              items: navigationData['items'],
            ),
          ),
        );
      },
    );
  }

  Map<String, dynamic> _getNavigationData(UserType userType) {
    switch (userType) {
      case UserType.customer:
        return {
          'screens': [
            const HomeScreen(),
            const ExploreScreen(),
            const ProductsScreen(),
            const BookingsScreen(),

            const AccountScreen(),
          ],
          'items': const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              activeIcon: Icon(Icons.shopping_bag),
              label: 'Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.calendar_today),
              label: 'Bookings',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Account',
            ),
          ],
        };

      case UserType.salon:
        return {
          'screens': [
            const SalonDashboardScreen(),
            const SalonBookingsScreen(),
            const SalonServicesScreen(),

            const AccountScreen(),
          ],
          'items': const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.calendar_today),
              label: 'Bookings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.content_cut),
              activeIcon: Icon(Icons.content_cut),
              label: 'Services',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Account',
            ),
          ],
        };

      case UserType.seller:
        return {
          'screens': [
            const SellerDashboardScreen(),
            const SellerProductsScreen(),
            const SellerOrdersScreen(),

            const AccountScreen(),
          ],
          'items': const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory_outlined),
              activeIcon: Icon(Icons.inventory),
              label: 'Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              activeIcon: Icon(Icons.shopping_cart),
              label: 'Orders',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Account',
            ),
          ],
        };
    }
  }
}