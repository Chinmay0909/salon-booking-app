import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../models/salon_model.dart';
import '../../screens/salon_detail_screen.dart';

class SpecialistsSection extends StatelessWidget {
  final List<SpecialistModel>? specialists;
  final bool showAll;

  const SpecialistsSection({
    super.key,
    this.specialists,
    this.showAll = false,
  });

  @override
  Widget build(BuildContext context) {
    final List<SpecialistModel> specialistList = specialists ?? _getSampleSpecialists();
    final displaySpecialists = showAll ? specialistList : specialistList.take(5).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Best Specialists',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (!showAll)
                GestureDetector(
                  onTap: () {
                    _showAllSpecialists(context);
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
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: displaySpecialists.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final specialist = displaySpecialists[index];
              return GestureDetector(
                onTap: () {
                  _navigateToSpecialist(context, specialist);
                },
                child: _buildSpecialistCard(specialist),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialistCard(SpecialistModel specialist) {
    return Container(
      width: 110,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(specialist.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (specialist.isVerified)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(
                        color: AppColors.background,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            specialist.name,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            specialist.specialty,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 12,
              ),
              const SizedBox(width: 2),
              Text(
                specialist.rating.toString(),
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToSpecialist(BuildContext context, SpecialistModel specialist) {
    // Option 1: Navigate to specialist detail screen (if exists)
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => SpecialistDetailScreen(specialist: specialist),
    //   ),
    // );

    // Option 2: Navigate to salon where specialist works (if salon data is available)
    if (specialist.salonId != null) {
      // Find the salon by ID and navigate to salon detail screen
      final salon = _findSalonById(specialist.salonId!);
      if (salon != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SalonDetailScreen(salon: salon),
          ),
        );
      }
    }
    // Note: Removed specialist details modal - no action taken if no salon ID
  }

  void _showAllSpecialists(BuildContext context) {
    // Navigate to a screen showing all specialists
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navigate to All Specialists Screen'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  SalonModel? _findSalonById(String salonId) {
    // This would typically fetch from your data source
    // For now, return null or implement based on your data structure
    return null;
  }

  List<SpecialistModel> _getSampleSpecialists() {
    return [
      SpecialistModel(
        id: '1',
        name: 'Tahir Osman',
        specialty: 'Hair Style',
        imageUrl: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=200&h=200&fit=crop&crop=face',
        isVerified: true,
        rating: 4.8,
        reviewCount: 156,
        experience: 8,
      ),
      SpecialistModel(
        id: '2',
        name: 'Ahmed Hassan',
        specialty: 'Beard Trim',
        imageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200&h=200&fit=crop&crop=face',
        isVerified: true,
        rating: 4.9,
        reviewCount: 203,
        experience: 12,
      ),
      SpecialistModel(
        id: '3',
        name: 'Mohamed Ali',
        specialty: 'Hair Cut',
        imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop&crop=face',
        isVerified: false,
        rating: 4.6,
        reviewCount: 89,
        experience: 5,
      ),
      SpecialistModel(
        id: '4',
        name: 'Omar Farouk',
        specialty: 'Skin Care',
        imageUrl: 'https://images.unsplash.com/photo-1566492031773-4f4e44671d66?w=200&h=200&fit=crop&crop=face',
        isVerified: true,
        rating: 4.7,
        reviewCount: 134,
        experience: 10,
      ),
      SpecialistModel(
        id: '5',
        name: 'Yusuf Ibrahim',
        specialty: 'Massage',
        imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&h=200&fit=crop&crop=face',
        isVerified: true,
        rating: 4.5,
        reviewCount: 76,
        experience: 6,
      ),
    ];
  }
}