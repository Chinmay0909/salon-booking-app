import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class ShopCard extends StatefulWidget {
  final String name;
  final String address;
  final String distance;
  final double rating;
  final String imageUrl;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onTap;
  final bool isOpen;
  final int? reviewCount;

  const ShopCard({
    super.key,
    required this.name,
    required this.address,
    required this.distance,
    required this.rating,
    required this.imageUrl,
    this.isFavorite = false,
    this.onFavoriteToggle,
    this.onTap,
    this.isOpen = true,
    this.reviewCount,
  });

  @override
  State<ShopCard> createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
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
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Status Badge (Open/Closed)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: widget.isOpen
                            ? Colors.green.withOpacity(0.9)
                            : Colors.red.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        widget.isOpen ? 'Open' : 'Closed',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  // Favorite Button
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isFavorite = !_isFavorite;
                        });
                        widget.onFavoriteToggle?.call();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: _isFavorite ? Colors.red : Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),

                  // Rating Badge
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 12,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            widget.rating.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (widget.reviewCount != null) ...[
                            const SizedBox(width: 2),
                            Text(
                              '(${widget.reviewCount})',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Content Section
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Salon Name
                    Text(
                      widget.name,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),

                    // Address
                    Text(
                      widget.address,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Distance
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColors.primary,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.distance,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),

                        // Book Now Button
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Book Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}