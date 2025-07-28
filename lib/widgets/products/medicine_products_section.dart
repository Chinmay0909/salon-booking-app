import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../screens/product_details_screen.dart';

class MedicineProductsSection extends StatelessWidget {
  const MedicineProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final medicines = [
      {
        'name': 'Paracetamol 500mg',
        'brand': 'PharmaCorp',
        'price': 12.99,
        'originalPrice': 15.99,
        'image': 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300&h=300&fit=crop',
        'images': [
          'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300&h=300&fit=crop',
          'https://images.unsplash.com/photo-1559757175-0eb30cd8c063?w=300&h=300&fit=crop',
        ],
        'rating': 4.6,
        'isOnSale': true,
        'category': 'Pain Relief',
        'reviewCount': 89,
        'description': 'Effective pain relief and fever reducer. Suitable for headaches, muscle pain, and reducing fever. Fast-acting formula provides relief within 30 minutes.',
        'specifications': {
          'Category': 'Pain Relief',
          'Strength': '500mg',
          'Pack Size': '20 tablets',
          'Active Ingredient': 'Paracetamol',
          'Dosage': '1-2 tablets every 4-6 hours',
          'Max Daily Dose': '8 tablets',
          'Prescription Required': 'No',
          'Storage': 'Store below 25°C',
          'Expiry': '24 months from manufacture',
          'Manufacturer': 'PharmaCorp Ltd',
        },
      },
      {
        'name': 'Vitamin D3 1000IU',
        'brand': 'HealthPlus',
        'price': 18.99,
        'originalPrice': null,
        'image': 'https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=300&h=300&fit=crop',
        'images': [
          'https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=300&h=300&fit=crop',
          'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300&h=300&fit=crop',
        ],
        'rating': 4.8,
        'isOnSale': false,
        'category': 'Vitamins & Supplements',
        'reviewCount': 167,
        'description': 'Essential vitamin D3 supplement to support bone health, immune function, and overall wellbeing. Easy-to-swallow capsules with optimal absorption.',
        'specifications': {
          'Category': 'Vitamins & Supplements',
          'Strength': '1000IU (25mcg)',
          'Pack Size': '60 capsules',
          'Active Ingredient': 'Cholecalciferol (Vitamin D3)',
          'Dosage': '1 capsule daily with food',
          'Suitable For': 'Adults and children over 12',
          'Prescription Required': 'No',
          'Storage': 'Store in cool, dry place',
          'Expiry': '36 months from manufacture',
          'Manufacturer': 'HealthPlus Nutrition',
        },
      },
      {
        'name': 'Cough Syrup',
        'brand': 'MediCare',
        'price': 8.99,
        'originalPrice': 11.99,
        'image': 'https://images.unsplash.com/photo-1559757175-0eb30cd8c063?w=300&h=300&fit=crop',
        'images': [
          'https://images.unsplash.com/photo-1559757175-0eb30cd8c063?w=300&h=300&fit=crop',
          'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300&h=300&fit=crop',
        ],
        'rating': 4.4,
        'isOnSale': true,
        'category': 'Cold & Flu',
        'reviewCount': 76,
        'description': 'Effective cough syrup for dry and productive cough. Provides soothing relief and helps reduce cough frequency. Honey-based formula with natural ingredients.',
        'specifications': {
          'Category': 'Cold & Flu',
          'Volume': '120ml',
          'Pack Size': '1 bottle',
          'Active Ingredients': 'Dextromethorphan, Honey, Ginger Extract',
          'Dosage': '10ml every 4-6 hours',
          'Age Group': 'Adults and children over 6 years',
          'Prescription Required': 'No',
          'Storage': 'Store at room temperature',
          'Expiry': '24 months from manufacture',
          'Manufacturer': 'MediCare Pharmaceuticals',
        },
      },
      {
        'name': 'Omega-3 Fish Oil',
        'brand': 'NutriMax',
        'price': 25.99,
        'originalPrice': null,
        'image': 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=300&h=300&fit=crop',
        'images': [
          'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=300&h=300&fit=crop',
          'https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=300&h=300&fit=crop',
        ],
        'rating': 4.7,
        'isOnSale': false,
        'category': 'Vitamins & Supplements',
        'reviewCount': 234,
        'description': 'High-quality omega-3 fish oil supplement supporting heart health, brain function, and joint mobility. Purified and tested for mercury and contaminants.',
        'specifications': {
          'Category': 'Vitamins & Supplements',
          'Strength': '1000mg per capsule',
          'Pack Size': '90 soft capsules',
          'Active Ingredients': 'EPA 300mg, DHA 200mg per capsule',
          'Dosage': '1-2 capsules daily with meals',
          'Source': 'Wild-caught fish',
          'Prescription Required': 'No',
          'Storage': 'Store in refrigerator after opening',
          'Expiry': '24 months from manufacture',
          'Manufacturer': 'NutriMax Health',
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
              Row(
                children: [
                  Icon(
                    Icons.local_pharmacy,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Medicines & Supplements',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
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
            itemCount: medicines.length,
            itemBuilder: (context, index) {
              final medicine = medicines[index];
              return _buildMedicineCard(context, medicine);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMedicineCard(BuildContext context, Map<String, dynamic> medicine) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: medicine),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.1),
            width: 1,
          ),
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
                  child: Container(
                    width: double.infinity,
                    height: 140,
                    color: Colors.white,
                    child: Image.network(
                      medicine['image'] as String,
                      width: double.infinity,
                      height: 140,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                if (medicine['isOnSale'] as bool)
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
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'RX',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                      ),
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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          medicine['category'] as String,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    medicine['brand'] as String,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    medicine['name'] as String,
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
                        medicine['rating'].toString(),
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${medicine['reviewCount']})',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '\$${medicine['price']}',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (medicine['originalPrice'] != null) ...[
                        const SizedBox(width: 4),
                        Text(
                          '\$${medicine['originalPrice']}',
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