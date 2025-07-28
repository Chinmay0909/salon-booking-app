import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/products/featured_products.dart';
import '../widgets/products/product_categories.dart';
import '../widgets/products/all_products_section.dart';
import '../widgets/products/medicine_products_section.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String selectedTab = 'All'; // All, Beauty, Medicine

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildSearchBar(),
              const SizedBox(height: 20),
              _buildTabSelector(),
              const SizedBox(height: 24),
              if (selectedTab == 'All' || selectedTab == 'Beauty') ...[
                const FeaturedProducts(),
                const SizedBox(height: 32),
                const ProductCategories(),
                const SizedBox(height: 32),
                const AllProductsSection(),
                const SizedBox(height: 32),
              ],
              if (selectedTab == 'All' || selectedTab == 'Medicine') ...[
                const MedicineProductsSection(),
                const SizedBox(height: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedTab == 'Medicine'
                      ? 'Health & Medicine'
                      : selectedTab == 'Beauty'
                      ? 'Beauty Products'
                      : 'Health & Beauty Store',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  selectedTab == 'Medicine'
                      ? 'Your trusted pharmacy partner'
                      : selectedTab == 'Beauty'
                      ? 'Find the best products for you'
                      : 'Beauty products & medicines delivered',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _buildIconButton(Icons.shopping_cart_outlined),
              const SizedBox(width: 12),
              _buildIconButton(Icons.notifications_outlined),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        icon,
        color: AppColors.textPrimary,
        size: 20,
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(
              Icons.search,
              color: AppColors.textSecondary,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: selectedTab == 'Medicine'
                      ? 'Search medicines...'
                      : selectedTab == 'Beauty'
                      ? 'Search beauty products...'
                      : 'Search products...',
                  hintStyle: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 8),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.tune,
                color: Colors.white,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildTabButton('All', Icons.apps),
          const SizedBox(width: 12),
          _buildTabButton('Beauty', Icons.face_retouching_natural),
          const SizedBox(width: 12),
          _buildTabButton('Medicine', Icons.local_pharmacy),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, IconData icon) {
    final isSelected = selectedTab == title;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = title),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : AppColors.textPrimary,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}