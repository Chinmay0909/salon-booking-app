import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../screens/product_details_screen.dart';

class FeaturedProducts extends StatelessWidget {
  const FeaturedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured Products',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'See All',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 280,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: 3,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              return _buildFeaturedProductCard(context, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedProductCard(BuildContext context, int index) {
    final products = [
      {
        'name': 'Hair Serum Premium',
        'brand': 'Loreal Paris',
        'price': 45.99,
        'originalPrice': 59.99,
        'image': 'https://images.unsplash.com/photo-1556228453-efd6c1ff04f6?w=300&h=300&fit=crop',
        'images': [
          'https://images.unsplash.com/photo-1556228453-efd6c1ff04f6?w=300&h=300&fit=crop',
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300&h=300&fit=crop',
          'https://images.unsplash.com/photo-1596755389378-c31d21fd1273?w=300&h=300&fit=crop',
        ],
        'rating': 4.8,
        'discount': 25,
        'category': 'Hair Care',
        'reviewCount': 342,
        'description': 'Transform your hair with this premium serum enriched with natural oils and vitamins. Designed to repair damaged hair, add shine, and provide long-lasting nourishment. Perfect for all hair types and daily use.',
        'specifications': {
          'Category': 'Hair Care',
          'Volume': '50ml',
          'Main Ingredients': 'Argan Oil, Vitamin E, Keratin',
          'Hair Type': 'All hair types',
          'Usage': 'Apply to damp or dry hair',
          'Country of Origin': 'France',
        },
      },
      {
        'name': 'Moisturizing Cream',
        'brand': 'Nivea',
        'price': 28.99,
        'originalPrice': 35.99,
        'image': 'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?w=300&h=300&fit=crop',
        'images': [
          'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?w=300&h=300&fit=crop',
          'https://images.unsplash.com/photo-1596755389378-c31d21fd1273?w=300&h=300&fit=crop',
        ],
        'rating': 4.6,
        'discount': 20,
        'category': 'Skin Care',
        'reviewCount': 198,
        'description': 'Daily moisturizing cream that provides 24-hour hydration. Formulated with natural ingredients to keep your skin soft, smooth, and healthy. Non-greasy formula absorbs quickly.',
        'specifications': {
          'Category': 'Skin Care',
          'Volume': '200ml',
          'Main Ingredients': 'Glycerin, Aloe Vera, Vitamin B5',
          'Skin Type': 'All skin types',
          'Usage': 'Apply twice daily',
          'Country of Origin': 'Germany',
        },
      },
      {
        'name': 'Vitamin C Serum',
        'brand': 'The Ordinary',
        'price': 32.99,
        'originalPrice': 42.99,
        'image': 'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop',
        'images': [
          'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop',
          'https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?w=300&h=300&fit=crop',
        ],
        'rating': 4.9,
        'discount': 23,
        'category': 'Skin Care',
        'reviewCount': 567,
        'description': 'High-potency vitamin C serum that brightens skin and reduces signs of aging. Contains 20% pure L-Ascorbic Acid for maximum effectiveness. Helps improve skin texture and tone.',
        'specifications': {
          'Category': 'Skin Care',
          'Volume': '30ml',
          'Main Ingredients': 'L-Ascorbic Acid 20%, Vitamin E',
          'Skin Type': 'Normal, Combination, Oily',
          'Usage': 'Use in AM routine',
          'Country of Origin': 'Canada',
        },
      },
    ];

    final product = products[index];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.network(
                    product['image'] as String,
                    width: 180,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${product['discount']}% OFF',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['brand'] as String,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product['name'] as String,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppColors.accent,
                        size: 12,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        product['rating'].toString(),
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '\$${product['price']}',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '\$${product['originalPrice']}',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}