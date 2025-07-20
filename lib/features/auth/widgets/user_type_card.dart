import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/user_type.dart';

class UserTypeCard extends StatelessWidget {
  final UserType userType;
  final VoidCallback onTap;

  const UserTypeCard({
    super.key,
    required this.userType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color getCardColor() {
      switch (userType) {
        case UserType.salon:
          return AppColors.primaryTeal;
        case UserType.seller:
          return AppColors.primaryYellow;
        default:
          return AppColors.primaryBlue;
      }
    }

    IconData getCardIcon() {
      switch (userType) {
        case UserType.salon:
          return Icons.content_cut;
        case UserType.seller:
          return Icons.store;
        default:
          return Icons.person;
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              getCardColor(),
              getCardColor().withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: getCardColor().withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              getCardIcon(),
              size: 60,
              color: Colors.white,
            ),
            const SizedBox(height: 16),
            Text(
              userType.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              userType.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}