import 'package:flutter/material.dart';
import '../../screens/bookmarks_screen.dart';
import '../../utils/app_colors.dart';
import '../../services/auth_service.dart';


class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        final user = AuthService().currentUser;

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: user?.hasAvatar == true
                      ? DecorationImage(
                    image: NetworkImage(user!.avatar!),
                    fit: BoxFit.cover,
                  )
                      : null,
                  color: user?.hasAvatar != true ? AppColors.primary : null,
                ),
                child: user?.hasAvatar != true
                    ? Center(
                  child: Text(
                    user?.initials ?? 'U',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, ${user?.firstName ?? 'User'}!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'What to do for you today?',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookmarksScreen(),
                        ),
                      );
                    },
                    child: _buildIconButton(Icons.bookmark_added_outlined),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      // Handle notifications tap
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Notifications feature coming soon!'),
                          backgroundColor: AppColors.surface,
                        ),
                      );
                    },
                    child: _buildIconButton(Icons.notifications_outlined),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        icon,
        color: AppColors.textPrimary,
        size: 20,
      ),
    );
  }
}