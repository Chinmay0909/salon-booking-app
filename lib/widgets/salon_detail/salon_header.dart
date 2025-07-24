// widgets/salon_detail/salon_header.dart

import 'package:flutter/material.dart';
import '../../models/salon_model.dart';
import '../../utils/app_colors.dart';

class SalonHeader extends StatelessWidget {
  final SalonModel salon;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onBackPressed;

  const SalonHeader({
    super.key,
    required this.salon,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main Image
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(salon.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Gradient Overlay
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        ),

        // Top Controls
        Positioned(
          top: MediaQuery.of(context).padding.top + 16,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back Button
              GestureDetector(
                onTap: onBackPressed,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),

              // Action Buttons
              Row(
                children: [
                  // Share Button
                  GestureDetector(
                    onTap: _shareSalon,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Favorite Button
                  GestureDetector(
                    onTap: onFavoriteToggle,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Rating Badge
        Positioned(
          top: MediaQuery.of(context).padding.top + 70,
          right: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  salon.rating.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '(${salon.reviewCount})',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Status Badge
        Positioned(
          top: MediaQuery.of(context).padding.top + 70,
          left: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: salon.isOpen
                  ? Colors.green.withOpacity(0.9)
                  : Colors.red.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  salon.isOpen ? 'Open Now' : 'Closed',
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

        // Bottom Info
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Salon Name
              Text(
                salon.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Address with Distance
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      salon.address,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${salon.distance} km',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Gallery Indicator (if multiple images)
        if (salon.galleryImages.length > 1)
          Positioned(
            bottom: 80,
            right: 20,
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
                    Icons.photo_library,
                    color: Colors.white,
                    size: 12,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${salon.galleryImages.length}+',
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
      ],
    );
  }

  void _shareSalon() {
    // TODO: Implement share functionality
    print('Share salon: ${salon.name}');
  }
}