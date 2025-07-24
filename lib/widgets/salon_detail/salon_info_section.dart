// widgets/salon_detail/salon_info_section.dart

import 'package:flutter/material.dart';
import '../../models/salon_model.dart';
import '../../utils/app_colors.dart';

class SalonInfoSection extends StatelessWidget {
  final SalonModel salon;

  const SalonInfoSection({
    super.key,
    required this.salon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description
        if (salon.description.isNotEmpty) ...[
          Text(
            'About',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            salon.description,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
        ],

        // Quick Info Cards
        Row(
          children: [
            // Rating Card
            Expanded(
              child: _buildInfoCard(
                icon: Icons.star,
                iconColor: Colors.amber,
                title: salon.rating.toString(),
                subtitle: '${salon.reviewCount} Reviews',
                onTap: () => _scrollToReviews(context),
              ),
            ),
            const SizedBox(width: 12),

            // Distance Card
            Expanded(
              child: _buildInfoCard(
                icon: Icons.location_on,
                iconColor: AppColors.primary,
                title: '${salon.distance} km',
                subtitle: 'Distance',
                onTap: () => _openMaps(context),
              ),
            ),
            const SizedBox(width: 12),

            // Services Count Card
            Expanded(
              child: _buildInfoCard(
                icon: Icons.content_cut,
                iconColor: Colors.green,
                title: salon.services.length.toString(),
                subtitle: 'Services',
                onTap: () => _scrollToServices(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Action Buttons
        Row(
          children: [
            // Call Button
            Expanded(
              child: _buildActionButton(
                icon: Icons.phone,
                label: 'Call',
                color: Colors.green,
                onPressed: () => _makeCall(context),
              ),
            ),
            const SizedBox(width: 12),

            // Directions Button
            Expanded(
              child: _buildActionButton(
                icon: Icons.directions,
                label: 'Directions',
                color: Colors.blue,
                onPressed: () => _openMaps(context),
              ),
            ),
            const SizedBox(width: 12),

            // Share Button
            Expanded(
              child: _buildActionButton(
                icon: Icons.share,
                label: 'Share',
                color: AppColors.primary,
                onPressed: () => _shareSalon(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Additional Info
        _buildAdditionalInfo(),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.textSecondary.withOpacity(0.1),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18, color: color),
      label: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color.withOpacity(0.3)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }

  Widget _buildAdditionalInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Additional Information',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          // Specialists Count
          _buildInfoRow(
            icon: Icons.people,
            title: 'Specialists',
            value: '${salon.specialists.length} Available',
          ),
          const SizedBox(height: 8),

          // Established (sample data)
          _buildInfoRow(
            icon: Icons.calendar_today,
            title: 'Established',
            value: '2018', // Sample data
          ),
          const SizedBox(height: 8),

          // Payment Methods
          _buildInfoRow(
            icon: Icons.payment,
            title: 'Payment',
            value: 'Cash, Card, Mobile Pay',
          ),
          const SizedBox(height: 8),

          // Parking
          _buildInfoRow(
            icon: Icons.local_parking,
            title: 'Parking',
            value: 'Available',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.textSecondary,
          size: 16,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _scrollToReviews(BuildContext context) {
    // TODO: Implement scroll to reviews section
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Scroll to reviews section')),
    );
  }

  void _scrollToServices(BuildContext context) {
    // TODO: Implement scroll to services section
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Scroll to services section')),
    );
  }

  void _makeCall(BuildContext context) {
    // TODO: Implement phone call functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Call salon functionality')),
    );
  }

  void _openMaps(BuildContext context) {
    // TODO: Implement maps functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Open maps for directions')),
    );
  }

  void _shareSalon(BuildContext context) {
    // TODO: Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share salon functionality')),
    );
  }
}