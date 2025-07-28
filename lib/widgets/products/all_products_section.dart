import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../screens/product_details_screen.dart';

class AllProductsSection extends StatelessWidget {
  const AllProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {
        'name': 'Hydrating Face Mask',
        'brand': 'Cetaphil',
        'price': 24.99,
        'originalPrice': 29.99,
        'image': 'https://images.unsplash.com/photo-1612817288484-6f916006741a?w=300&h=300&fit=crop',
        'images': [
          'https://images.unsplash.com/photo-1612817288484-6f916006741a?w=300&h=300&fit=crop',
          'https://images.unsplash.com/photo-1596755389378-c31d21fd1273?w=300&h=300&fit=crop',
        ],
        'rating': 4.7,
        'isOnSale': true,
        'category': 'Skin Care',
        'reviewCount': 156,
        'description': 'Deeply hydrating face mask that restores moisture and leaves skin feeling soft and refreshed. Formulated with hyaluronic acid and natural botanicals for optimal hydration.',
        'specifications': {
          'Category': 'Skin Care',
          'Volume': '150ml',
          'Main Ingredients': 'Hyaluronic Acid, Aloe Vera, Chamomile',
          'Skin Type': 'All skin types, especially dry',
          'Usage': 'Apply 2-3 times per week',
          'Country of Origin': 'USA',
        },
      },
      {
        'name': 'Argan Oil Treatment',
        'brand': 'Moroccan Oil',
        'price': 38.99,
        'originalPrice': null,
        'image': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300&h=300&fit=crop',
        'images': [
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300&h=300&fit=crop',
          'https://images.unsplash.com/photo-1556228453-efd6c1ff04f6?w=300&h=300&fit=crop',
        ],
        'rating': 4.8,
        'isOnSale': false,
        'category': 'Hair Care',
        'reviewCount': 289,
        'description': 'Pure argan oil treatment that nourishes and repairs damaged hair. Rich in vitamin E and essential fatty acids for healthy, shiny hair.',
        'specifications': {
          'Category': 'Hair Care',
          'Volume': '100ml',
          'Main Ingredients': '100% Pure Argan Oil',
          'Hair Type': 'All hair types, especially damaged',
          'Usage': 'Apply to damp or dry hair',
          'Country of Origin': 'Morocco',
        },
      },
      {
        'name': 'Vitamin E Cream',
        'brand': 'The Body Shop',
        'price': 18.99,
        'originalPrice': 24.99,
        'image': 'https://images.unsplash.com/photo-1596755389378-c31d21fd1273?w=300&h=300&fit=crop',
        'images': [
          'https://images.unsplash.com/photo-1596755389378-c31d21fd1273?w=300&h=300&fit=crop',
          'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?w=300&h=300&fit=crop',
        ],
        'rating': 4.5,
        'isOnSale': true,
        'category': 'Skin Care',
        'reviewCount': 124,
        'description': 'Nourishing vitamin E cream that protects and moisturizes skin. Helps prevent signs of aging and keeps skin looking youthful and radiant.',
        'specifications': {
          'Category': 'Skin Care',
          'Volume': '50ml',
          'Main Ingredients': 'Vitamin E, Shea Butter, Glycerin',
          'Skin Type': 'Normal to dry skin',
          'Usage': 'Apply daily morning and evening',
          'Country of Origin': 'UK',
        },
      },
      {
        'name': 'Retinol Night Serum',
        'brand': 'Olay',
        'price': 42.99,
        'originalPrice': null,
        'image': 'https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?w=300&h=300&fit=crop',
        'images': [
          'https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?w=300&h=300&fit=crop',
          'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop',
        ],
        'rating': 4.9,
        'isOnSale': false,
        'category': 'Skin Care',
        'reviewCount': 423,
        'description': 'Advanced retinol night serum that helps reduce fine lines and improves skin texture. Gentle formula suitable for nightly use to reveal smoother, younger-looking skin.',
        'specifications': {
          'Category': 'Skin Care',
          'Volume': '30ml',
          'Main Ingredients': 'Retinol, Niacinamide, Peptides',
          'Skin Type': 'Normal, Combination, Mature',
          'Usage': 'Apply at night only',
          'Country of Origin': 'USA',
        },
      },
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All Products',
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return _buildProductCard(context, product);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> product) {
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
                    width: double.infinity,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
                if (product['isOnSale'] as bool)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'SALE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['brand'] as String,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product['name'] as String,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppColors.accent,
                        size: 10,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        product['rating'].toString(),
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '\$${product['price']}',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (product['originalPrice'] != null) ...[
                        const SizedBox(width: 4),
                        Text(
                          '\$${product['originalPrice']}',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 10,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
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