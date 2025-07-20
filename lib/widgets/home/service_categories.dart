import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class ServiceCategories extends StatelessWidget {
  const ServiceCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'title': 'Haircuts',
        'icon': Icons.content_cut,
        'color': AppColors.haircuts,
      },
      {
        'title': 'Make up',
        'icon': Icons.face_retouching_natural,
        'color': AppColors.makeup,
      },
      {
        'title': 'Manicure',
        'icon': Icons.back_hand,
        'color': AppColors.manicure,
      },
      {
        'title': 'Massage',
        'icon': Icons.spa,
        'color': AppColors.massage,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: categories.map((category) {
          return _buildCategoryItem(
            title: category['title'] as String,
            icon: category['icon'] as IconData,
            color: category['color'] as Color,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryItem({
    required String title,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            icon,
            color: color,
            size: 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}