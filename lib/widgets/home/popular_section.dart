import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../common/shop_card.dart';

class PopularSection extends StatelessWidget {
  const PopularSection({super.key});

  @override
  Widget build(BuildContext context) {
    final popularShops = [
      {
        'name': 'Captains Barbershop',
        'address': 'KK 15 AVE Street, Kigali, RW',
        'distance': '1.2 km',
        'rating': 4.8,
        'image': 'https://images.unsplash.com/photo-1585747860715-2ba37e788b70?w=300&h=200&fit=crop',
        'isFavorite': false,
      },
      {
        'name': 'Elite Hair Studio',
        'address': 'KK 20 AVE Street, Kigali, RW',
        'distance': '0.8 km',
        'rating': 4.9,
        'image': 'https://images.unsplash.com/photo-1562322140-8198e7b19f2f?w=300&h=200&fit=crop',
        'isFavorite': true,
      },
      {
        'name': 'Modern Cuts',
        'address': 'KK 12 AVE Street, Kigali, RW',
        'distance': '2.1 km',
        'rating': 4.7,
        'image': 'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?w=300&h=200&fit=crop',
        'isFavorite': false,
      },
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Most Popular',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.local_fire_department,
                    color: AppColors.primary,
                    size: 18,
                  ),
                ],
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
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: popularShops.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final shop = popularShops[index];
            return ShopCard(
              name: shop['name'] as String,
              address: shop['address'] as String,
              distance: shop['distance'] as String,
              rating: shop['rating'] as double,
              imageUrl: shop['image'] as String,
              isFavorite: shop['isFavorite'] as bool,
            );
          },
        ),
      ],
    );
  }
}