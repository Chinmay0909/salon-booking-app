// screens/salon_detail_screen.dart

import 'package:flutter/material.dart';
import '../models/salon_model.dart';
import '../utils/app_colors.dart';
import '../widgets/salon_detail/salon_header.dart';
import '../widgets/salon_detail/salon_info_section.dart';
import '../widgets/salon_detail/specialists_horizontal_list.dart';
import '../widgets/salon_detail/services_list.dart';
import '../widgets/salon_detail/reviews_section.dart';
import '../widgets/salon_detail/gallery_section.dart';

class SalonDetailScreen extends StatefulWidget {
  final SalonModel salon;

  const SalonDetailScreen({
    super.key,
    required this.salon,
  });

  @override
  State<SalonDetailScreen> createState() => _SalonDetailScreenState();
}

class _SalonDetailScreenState extends State<SalonDetailScreen> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.salon.isFavorite ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Main Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Image
                SalonHeader(
                  salon: widget.salon,
                  isFavorite: _isFavorite,
                  onFavoriteToggle: _toggleFavorite,
                  onBackPressed: () => Navigator.pop(context),
                ),

                // Content Sections
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Basic Info Section
                      SalonInfoSection(salon: widget.salon),
                      const SizedBox(height: 32),

                      // Specialists Section
                      if (widget.salon.specialists.isNotEmpty) ...[
                        _buildSectionTitle('Our Specialists'),
                        const SizedBox(height: 16),
                        SpecialistsHorizontalList(specialists: widget.salon.specialists),
                        const SizedBox(height: 32),
                      ],

                      // Services Section
                      if (widget.salon.services.isNotEmpty) ...[
                        _buildSectionTitle('Services'),
                        const SizedBox(height: 16),
                        ServicesList(services: widget.salon.services),
                        const SizedBox(height: 32),
                      ],

                      // Gallery Section
                      if (widget.salon.galleryImages.isNotEmpty) ...[
                        _buildSectionTitle('Gallery'),
                        const SizedBox(height: 16),
                        GallerySection(images: widget.salon.galleryImages),
                        const SizedBox(height: 32),
                      ],

                      // Reviews Section
                      if (widget.salon.reviews.isNotEmpty) ...[
                        _buildSectionTitle('Reviews (${widget.salon.reviewCount})'),
                        const SizedBox(height: 16),
                        ReviewsSection(
                          reviews: widget.salon.reviews,
                          averageRating: widget.salon.rating,
                        ),
                        const SizedBox(height: 32),
                      ],

                      // Schedule Section
                      _buildSectionTitle('Opening Hours'),
                      const SizedBox(height: 16),
                      _buildScheduleSection(),
                      const SizedBox(height: 100), // Space for floating button
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Floating Book Appointment Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.background,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: widget.salon.isOpen ? _bookAppointment : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.salon.isOpen
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      widget.salon.isOpen ? 'Book Appointment' : 'Salon Closed',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildScheduleSection() {
    final schedule = widget.salon.schedule.weeklySchedule;
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: days.map((day) {
          final hours = schedule[day];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  day,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  hours?.isClosed == true
                      ? 'Closed'
                      : '${hours?.openTime} - ${hours?.closeTime}',
                  style: TextStyle(
                    color: hours?.isClosed == true
                        ? AppColors.textSecondary
                        : AppColors.textPrimary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    // TODO: Update favorite status in database/storage
    widget.salon.isFavorite = _isFavorite;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite
              ? '${widget.salon.name} added to favorites'
              : '${widget.salon.name} removed from favorites',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _bookAppointment() {
    // TODO: Navigate to booking screen or show booking dialog
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildBookingBottomSheet(),
    );
  }

  Widget _buildBookingBottomSheet() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textSecondary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Book Appointment',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Booking content placeholder
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Service selection
                  Text(
                    'Select a service to continue with booking',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Services list
                  ...widget.salon.services.take(3).map((service) =>
                      Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.textSecondary.withOpacity(0.2)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  service.name,
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${service.duration} minutes',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '\$${service.price}',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ).toList(),

                  const Spacer(),

                  // Continue button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Navigate to booking flow'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Continue Booking',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}