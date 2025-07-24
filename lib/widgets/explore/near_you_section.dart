import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../models/salon_model.dart';
import '../../screens/salon_detail_screen.dart';
import '../common/shop_card.dart';

class NearYouSection extends StatelessWidget {
  final List<SalonModel>? salons;
  final bool showAll;

  const NearYouSection({
    super.key,
    this.salons,
    this.showAll = false,
  });

  @override
  Widget build(BuildContext context) {
    final List<SalonModel> nearbyShops = salons ?? _getSampleNearbyShops();
    final displayShops = showAll ? nearbyShops : nearbyShops.take(3).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Near to you',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (!showAll)
                GestureDetector(
                  onTap: () {
                    // Navigate to a screen showing all nearby salons
                    _showAllNearbyShops(context);
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
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: displayShops.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final shop = displayShops[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SalonDetailScreen(salon: shop),
                  ),
                );
              },
              child: ShopCard(
                name: shop.name,
                address: shop.address,
                distance: '${shop.distance} km',
                rating: shop.rating,
                imageUrl: shop.imageUrl,
                isFavorite: shop.isFavorite ?? false,
                onFavoriteToggle: () {
                  _toggleFavorite(shop);
                },
              ),
            );
          },
        ),
      ],
    );
  }

  void _showAllNearbyShops(BuildContext context) {
    // You can navigate to a dedicated screen showing all nearby shops
    // For now, we'll just print a message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navigate to All Nearby Shops Screen'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _toggleFavorite(SalonModel salon) {
    // TODO: Implement favorite toggle logic
    // This would typically involve calling an API or updating local storage
    print('Toggle favorite for salon: ${salon.name}');
  }

  List<SalonModel> _getSampleNearbyShops() {
    return [
      SalonModel(
        id: 'nearby_1',
        name: 'Captains Barbershop',
        address: 'KK 15 AVE Street, Kigali, RW',
        rating: 4.8,
        reviewCount: 1250,
        distance: 1.2,
        isOpen: true,
        isFavorite: false,
        imageUrl: 'https://images.unsplash.com/photo-1585747860715-2ba37e788b70?w=300&h=200&fit=crop',
        description: 'Professional barbershop with experienced stylists in the heart of Kigali.',
        specialists: SpecialistModel.sampleList(),
        services: ServiceModel.sampleList(),
        schedule: ScheduleModel.sampleSchedule(),
        reviews: ReviewModel.sampleList(),
        galleryImages: [
          'https://images.unsplash.com/photo-1585747860715-2ba37e788b70?w=300',
          'https://images.unsplash.com/photo-1562322140-8198e7b19f2f?w=300',
        ],
      ),
      SalonModel(
        id: 'nearby_2',
        name: 'Elite Hair Studio',
        address: 'KG 11 AVE Road, Kigali, RW',
        rating: 4.9,
        reviewCount: 890,
        distance: 1.8,
        isOpen: true,
        isFavorite: true,
        imageUrl: 'https://images.unsplash.com/photo-1562322140-8198e7b19f2f?w=300&h=200&fit=crop',
        description: 'Modern hair studio offering premium styling services.',
        specialists: SpecialistModel.sampleList(),
        services: ServiceModel.sampleList(),
        schedule: ScheduleModel.sampleSchedule(),
        reviews: ReviewModel.sampleList(),
        galleryImages: [
          'https://images.unsplash.com/photo-1562322140-8198e7b19f2f?w=300',
          'https://images.unsplash.com/photo-1585747860715-2ba37e788b70?w=300',
        ],
      ),
      SalonModel(
        id: 'nearby_3',
        name: 'Style Masters',
        address: 'KK 25 Street, Kigali, RW',
        rating: 4.7,
        reviewCount: 650,
        distance: 2.1,
        isOpen: true,
        isFavorite: false,
        imageUrl: 'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?w=300&h=200&fit=crop',
        description: 'Traditional barbershop with modern techniques and friendly service.',
        specialists: SpecialistModel.sampleList(),
        services: ServiceModel.sampleList(),
        schedule: ScheduleModel.sampleSchedule(),
        reviews: ReviewModel.sampleList(),
        galleryImages: [
          'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?w=300',
          'https://images.unsplash.com/photo-1585747860715-2ba37e788b70?w=300',
        ],
      ),
      SalonModel(
        id: 'nearby_4',
        name: 'Urban Cuts',
        address: 'KN 5 AVE, Kigali, RW',
        rating: 4.6,
        reviewCount: 420,
        distance: 2.5,
        isOpen: false,
        isFavorite: false,
        imageUrl: 'https://images.unsplash.com/photo-1560066984-138dadb4c035?w=300&h=200&fit=crop',
        description: 'Trendy salon specializing in contemporary cuts and styles.',
        specialists: SpecialistModel.sampleList(),
        services: ServiceModel.sampleList(),
        schedule: ScheduleModel.sampleSchedule(),
        reviews: ReviewModel.sampleList(),
        galleryImages: [
          'https://images.unsplash.com/photo-1560066984-138dadb4c035?w=300',
          'https://images.unsplash.com/photo-1562322140-8198e7b19f2f?w=300',
        ],
      ),
    ];
  }
}