import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/user_type.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final UserType? userType;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.userType,
  });

  @override
  Widget build(BuildContext context) {
    Color getColorByUserType() {
      switch (userType) {
        case UserType.salon:
          return AppColors.primaryTeal;
        case UserType.seller:
          return AppColors.primaryYellow;
        default:
          return AppColors.primaryBlue;
      }
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            getColorByUserType(),
            getColorByUserType().withOpacity(0.8),
          ],
        ),
      ),
      child: Column(
        children: [
          if (userType != null) ...[
            Icon(
              _getIconByUserType(),
              size: 60,
              color: Colors.white,
            ),
            const SizedBox(height: 16),
          ],
          Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  IconData _getIconByUserType() {
    switch (userType) {
      case UserType.salon:
        return Icons.content_cut;
      case UserType.seller:
        return Icons.store;
      default:
        return Icons.person;
    }
  }
}