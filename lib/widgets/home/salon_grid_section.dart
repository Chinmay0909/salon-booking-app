import 'package:flutter/material.dart';
import '../../models/salon_model.dart';
import '../../screens/salon_detail_screen.dart';

class SalonGridSection extends StatelessWidget {
  const SalonGridSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<SalonModel> salons = _getSampleSalons();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nearby Salons',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'See All',
                style: TextStyle(
                  color: Color(0xFFFF4757),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Salon Grid
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemCount: salons.length,
            itemBuilder: (context, index) {
              return _buildSalonGridCard(context, salons[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSalonGridCard(BuildContext context, SalonModel salon) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SalonDetailScreen(salon: salon),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image and Icons
            Stack(
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(salon.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Bookmark Icon
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.bookmark_border,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
                // Rating
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 12,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          salon.rating.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Salon Name
                    Text(
                      salon.name,
                      style: const TextStyle(
                        color: Colors.white,
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
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),

                    // Distance
                    Row(
                      children: [
                        const Icon(
                          Icons.location_pin,
                          color: Color(0xFFFF4757),
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${salon.distance} km',
                          style: const TextStyle(
                            color: Color(0xFFFF4757),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
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

  List<SalonModel> _getSampleSalons() {
    return [
      SalonModel(
        id: '1',
        name: 'MG Barbershop',
        address: 'KK 15 AVE Street, Kigali,',
        rating: 4.8,
        reviewCount: 1250,
        distance: 1.2,
        isOpen: true,
        imageUrl: 'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?w=400',
        description: 'Professional barbershop with experienced stylists.',
        specialists: SpecialistModel.sampleList(),
        services: ServiceModel.sampleList(),
        schedule: ScheduleModel.sampleSchedule(),
        reviews: ReviewModel.sampleList(),
        galleryImages: [
          'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?w=300',
          'https://images.unsplash.com/photo-1560066984-138dadb4c035?w=300',
        ],
      ),
      SalonModel(
        id: '2',
        name: 'MG Barbershop',
        address: 'KK 15 AVE Street, Kigali,',
        rating: 4.8,
        reviewCount: 980,
        distance: 1.2,
        isOpen: true,
        imageUrl: 'https://images.unsplash.com/photo-1560066984-138dadb4c035?w=400',
        description: 'Modern salon with premium services.',
        specialists: SpecialistModel.sampleList(),
        services: ServiceModel.sampleList(),
        schedule: ScheduleModel.sampleSchedule(),
        reviews: ReviewModel.sampleList(),
        galleryImages: [
          'https://images.unsplash.com/photo-1560066984-138dadb4c035?w=300',
          'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?w=300',
        ],
      ),
      SalonModel(
        id: '3',
        name: 'MG Barbershop',
        address: 'KK 15 AVE Street, Kigali,',
        rating: 4.8,
        reviewCount: 750,
        distance: 1.2,
        isOpen: true,
        imageUrl: 'https://images.unsplash.com/photo-1521490878405-2fc188d189b4?w=400',
        description: 'Trendy barbershop with skilled professionals.',
        specialists: SpecialistModel.sampleList(),
        services: ServiceModel.sampleList(),
        schedule: ScheduleModel.sampleSchedule(),
        reviews: ReviewModel.sampleList(),
        galleryImages: [
          'https://images.unsplash.com/photo-1521490878405-2fc188d189b4?w=300',
          'https://images.unsplash.com/photo-1560066984-138dadb4c035?w=300',
        ],
      ),
      SalonModel(
        id: '4',
        name: 'MG Barbershop',
        address: 'KK 15 AVE Street, Kigali,',
        rating: 4.8,
        reviewCount: 1100,
        distance: 1.2,
        isOpen: true,
        imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=400',
        description: 'Premium barbershop experience.',
        specialists: SpecialistModel.sampleList(),
        services: ServiceModel.sampleList(),
        schedule: ScheduleModel.sampleSchedule(),
        reviews: ReviewModel.sampleList(),
        galleryImages: [
          'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300',
          'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?w=300',
        ],
      ),
      SalonModel(
        id: '5',
        name: 'MG Barbershop',
        address: 'KK 15 AVE Street, Kigali,',
        rating: 4.8,
        reviewCount: 890,
        distance: 1.2,
        isOpen: true,
        imageUrl: 'https://images.unsplash.com/photo-1622286342621-4bd786c2447c?w=400',
        description: 'Classic barbershop with modern touch.',
        specialists: SpecialistModel.sampleList(),
        services: ServiceModel.sampleList(),
        schedule: ScheduleModel.sampleSchedule(),
        reviews: ReviewModel.sampleList(),
        galleryImages: [
          'https://images.unsplash.com/photo-1622286342621-4bd786c2447c?w=300',
          'https://images.unsplash.com/photo-1560066984-138dadb4c035?w=300',
        ],
      ),
      SalonModel(
        id: '6',
        name: 'MG Barbershop',
        address: 'KK 15 AVE Street, Kigali,',
        rating: 4.8,
        reviewCount: 650,
        distance: 1.2,
        isOpen: true,
        imageUrl: 'https://images.unsplash.com/photo-1559599101-f09722fb4948?w=400',
        description: 'Expert stylists and premium services.',
        specialists: SpecialistModel.sampleList(),
        services: ServiceModel.sampleList(),
        schedule: ScheduleModel.sampleSchedule(),
        reviews: ReviewModel.sampleList(),
        galleryImages: [
          'https://images.unsplash.com/photo-1559599101-f09722fb4948?w=300',
          'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?w=300',
        ],
      ),
    ];
  }
}