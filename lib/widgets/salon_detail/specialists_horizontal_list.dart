// widgets/salon_detail/specialists_horizontal_list.dart

import 'package:flutter/material.dart';
import '../../models/salon_model.dart';
import '../../utils/app_colors.dart';

class SpecialistsHorizontalList extends StatelessWidget {
  final List<SpecialistModel> specialists;

  const SpecialistsHorizontalList({
    super.key,
    required this.specialists,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: specialists.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final specialist = specialists[index];
          return GestureDetector(
            onTap: () => _showSpecialistDetails(context, specialist),
            child: _buildSpecialistCard(specialist),
          );
        },
      ),
    );
  }

  Widget _buildSpecialistCard(SpecialistModel specialist) {
    return Container(
      width: 120,
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
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Profile Image with Verification Badge
            Stack(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
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
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.cardBackground,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),

            // Name
            Text(
              specialist.name,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            // Specialty
            Text(
              specialist.specialty,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),

            // Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12,
                ),
                const SizedBox(width: 2),
                Text(
                  specialist.rating.toString(),
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 2),
                Text(
                  '(${specialist.reviewCount})',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Experience
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${specialist.experience}y exp',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSpecialistDetails(BuildContext context, SpecialistModel specialist) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (context, scrollController) => SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.textSecondary.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Specialist Profile
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          image: DecorationImage(
                            image: NetworkImage(specialist.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  specialist.name,
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (specialist.isVerified) ...[
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.verified,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              specialist.specialty,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${specialist.rating} (${specialist.reviewCount} reviews)',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Quick Stats
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'Experience',
                          '${specialist.experience} Years',
                          Icons.work,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          'Rating',
                          '${specialist.rating}/5.0',
                          Icons.star,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          'Reviews',
                          '${specialist.reviewCount}+',
                          Icons.reviews,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Services (if available)
                  if (specialist.services != null && specialist.services!.isNotEmpty) ...[
                    Text(
                      'Services Offered',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: specialist.services!.map((service) =>
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                            ),
                            child: Text(
                              service,
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Book Appointment Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _bookWithSpecialist(context, specialist);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Book with ${specialist.name.split(' ')[0]}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.textSecondary.withOpacity(0.1),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 20,
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _bookWithSpecialist(BuildContext context, SpecialistModel specialist) {
    // TODO: Navigate to booking screen with pre-selected specialist
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Book appointment with ${specialist.name}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}