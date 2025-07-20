import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/home/header_section.dart';
import '../widgets/home/search_bar_widget.dart';
import '../widgets/home/promo_banner.dart';
import '../widgets/home/service_categories.dart';
import '../widgets/home/popular_section.dart';
import '../widgets/home/salon_grid_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 80, // Account for bottom nav bar
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderSection(),
                const SizedBox(height: 16), // Reduced from 20
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SearchBarWidget(),
                ),
                const SizedBox(height: 24), // Reduced from 32
                const PromoBanner(),
                const SizedBox(height: 24), // Reduced from 32
                const ServiceCategories(),
                const SizedBox(height: 24), // Reduced from 32
                const PopularSection(),
                const SizedBox(height: 24), // Added spacing before salon grid
                const SalonGridSection(), // New salon grid section
                const SizedBox(height: 16), // Reduced from 20
              ],
            ),
          ),
        ),
      ),
    );
  }
}