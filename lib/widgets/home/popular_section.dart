import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../models/salon_model.dart';
import '../../screens/salon_detail_screen.dart';

class PopularSection extends StatelessWidget {
  final List<SalonModel>? salons;
  final bool showAll;

  const PopularSection({
    super.key,
    this.salons,
    this.showAll = false,
  });

  @override
  Widget build(BuildContext context) {
    final List<SalonModel> popularSalons = salons ?? _getSamplePopularSalons();
    final displaySalons = showAll ? popularSalons : popularSalons.take(3).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Most Popular',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (!showAll)
                GestureDetector(
                  onTap: () {
                    _showAllPopularSalons(context);
                  },
                  child: Text(
                    'See All',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: displaySalons.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final salon = displaySalons[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SalonDetailScreen(salon: salon),
                    ),
                  );
                },
                child: _buildPopularSalonCard(salon),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPopularSalonCard(SalonModel salon) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Stack(
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(salon.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Popular Badge
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'POPULAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),

                // Rating Badge
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 10,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          salon.rating.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Status Badge
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: salon.isOpen
                          ? Colors.green.withOpacity(0.9)
                          : Colors.red.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      salon.isOpen ? 'OPEN' : 'CLOSED',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Content Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Salon Name
                    Text(
                      salon.name,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Address
                    Text(
                      salon.address,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),

                    // Distance and Reviews
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColors.primary,
                          size: 12,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${salon.distance} km',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '(${salon.reviewCount})',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAllPopularSalons(BuildContext context) {
    // Navigate to a screen showing all popular salons
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navigate to All Popular Salons Screen'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  List<SalonModel> _getSamplePopularSalons() {
    return [
      SalonModel(
        id: 'popular_1',
        name: 'Premium Cuts',
        address: 'City Center, Kigali',
        rating: 4.9,
        reviewCount: 1520,
        distance: 0.8,
        isOpen: true,
        imageUrl: 'https://images.unsplash.com/photo-1521490878405-2fc188d189b4?w=400',
        description: 'The most popular barbershop in the city with award-winning stylists.',
        specialists: SpecialistModel.sampleList(),
        services: ServiceModel.sampleList(),
        schedule: ScheduleModel.sampleSchedule(),
        reviews: ReviewModel.sampleList(),
        galleryImages: [
          'https://images.unsplash.com/photo-1521490878405-2fc188d189b4?w=300',
          'https://images.unsplash.com/photo-1560066984-138dadb4c035?w=300',
        ],
        isFavorite: false,
      ),
      SalonModel(
        id: 'popular_2',
        name: 'Elite Barbershop',
        address: 'Downtown District',
        rating: 4.8,
        reviewCount: 987,
        distance: 1.5,
        isOpen: true,
        imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=400',
        description: 'Elite barbershop known for precision cuts and premium service.',
        specialists: SpecialistModel.sampleList(),
        services: ServiceModel.sampleList(),
        schedule: ScheduleModel.sampleSchedule(),
        reviews: ReviewModel.sampleList(),
        galleryImages: [
          'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300',
          'https://images.unsplash.com/photo-1521490878405-2fc188d189b4?w=300',
        ],
        isFavorite: true,
      ),
      SalonModel(
        id: 'popular_3',
        name: 'The Gentleman\'s Club',
        address: 'Business District',
        rating: 4.7,
        reviewCount: 756,
        distance: 2.2,
        isOpen: true,
        imageUrl: 'https://images.unsplash.com/photo-1622286342621-4bd786c2447c?w=400',
        description: 'Classic gentleman\'s barbershop with traditional and modern services.',
        specialists: SpecialistModel.sampleList(),
        services: ServiceModel.sampleList(),
        schedule: ScheduleModel.sampleSchedule(),
        reviews: ReviewModel.sampleList(),
        galleryImages: [
          'https://images.unsplash.com/photo-1622286342621-4bd786c2447c?w=300',
          'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300',
        ],
        isFavorite: false,
      ),
      SalonModel(
        id: 'popular_4',
        name: 'Modern Style Studio',
        address: 'Fashion Quarter',
        rating: 4.6,
        reviewCount: 543,
        distance: 3.0,
        isOpen: false,
        imageUrl: 'https://images.unsplash.com/photo-1559599101-f09722fb4948?w=400',
        description: 'Contemporary styling studio with the latest trends and techniques.',
        specialists: SpecialistModel.sampleList(),
        services: ServiceModel.sampleList(),
        schedule: ScheduleModel.sampleSchedule(),
        reviews: ReviewModel.sampleList(),
        galleryImages: [
          'https://images.unsplash.com/photo-1559599101-f09722fb4948?w=300',
          'https://images.unsplash.com/photo-1622286342621-4bd786c2447c?w=300',
        ],
        isFavorite: false,
      ),
    ];
  }
}