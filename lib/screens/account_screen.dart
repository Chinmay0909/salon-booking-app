import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        final user = AuthService().currentUser;

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildProfileSection(user),
                  const SizedBox(height: 24),
                  _buildMenuSection(context),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Manage your profile and settings',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.settings,
              color: AppColors.textPrimary,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection(user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
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
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.displayName ?? 'User Name',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user?.email ?? 'user@email.com',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          user?.membershipType ?? 'Basic Member',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (user?.isSalon == true && user?.rating != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                color: AppColors.accent,
                                size: 12,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                '${user!.rating}',
                                style: TextStyle(
                                  color: AppColors.accent,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (user?.isSeller == true && user?.isVerifiedSeller == true) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.success.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.verified,
                                color: AppColors.success,
                                size: 12,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                'Verified',
                                style: TextStyle(
                                  color: AppColors.success,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  // Additional info based on user type
                  if (user?.isSalon == true && user?.services != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Services: ${(user!.services as List).take(3).join(", ")}${(user.services as List).length > 3 ? "..." : ""}',
                      style: TextStyle(
                        color: AppColors.textTertiary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                  if (user?.isSeller == true && user?.productCategories != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Categories: ${(user!.productCategories as List).take(3).join(", ")}${(user.productCategories as List).length > 3 ? "..." : ""}',
                      style: TextStyle(
                        color: AppColors.textTertiary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    final user = AuthService().currentUser;

    // Base menu items for all user types
    List<Map<String, dynamic>> baseMenuItems = [
      {
        'title': 'Personal Information',
        'icon': Icons.person_outline,
        'subtitle': 'Update your personal details',
      },
      {
        'title': 'Notifications',
        'icon': Icons.notifications_outlined,
        'subtitle': 'Configure your notification settings',
      },
    ];

    // User-type specific menu items
    List<Map<String, dynamic>> typeSpecificItems = [];

    if (user?.isCustomer == true) {
      typeSpecificItems = [
        {
          'title': 'Payment Methods',
          'icon': Icons.credit_card_outlined,
          'subtitle': 'Manage your payment options',
        },
        {
          'title': 'Favorites',
          'icon': Icons.favorite_outline,
          'subtitle': 'View your saved shops and services',
        },
        {
          'title': 'Booking History',
          'icon': Icons.history,
          'subtitle': 'View your past appointments',
        },
        {
          'title': 'Reviews & Ratings',
          'icon': Icons.star_outline,
          'subtitle': 'Your reviews and feedback',
        },
      ];
    } else if (user?.isSalon == true) {
      typeSpecificItems = [
        {
          'title': 'Business Information',
          'icon': Icons.business,
          'subtitle': 'Update salon details and hours',
        },
        {
          'title': 'Services & Pricing',
          'icon': Icons.content_cut,
          'subtitle': 'Manage your service offerings',
        },
        {
          'title': 'Staff Management',
          'icon': Icons.people,
          'subtitle': 'Manage your team members',
        },
        {
          'title': 'Business Analytics',
          'icon': Icons.analytics,
          'subtitle': 'View performance metrics',
        },
        {
          'title': 'Customer Reviews',
          'icon': Icons.rate_review,
          'subtitle': 'Manage customer feedback',
        },
      ];
    } else if (user?.isSeller == true) {
      typeSpecificItems = [
        {
          'title': 'Company Information',
          'icon': Icons.business,
          'subtitle': 'Update company details',
        },
        {
          'title': 'Product Management',
          'icon': Icons.inventory,
          'subtitle': 'Manage your product catalog',
        },
        {
          'title': 'Order Management',
          'icon': Icons.shopping_cart,
          'subtitle': 'Track and manage orders',
        },
        {
          'title': 'Sales Analytics',
          'icon': Icons.trending_up,
          'subtitle': 'View sales performance',
        },
        {
          'title': 'Verification Status',
          'icon': Icons.verified,
          'subtitle': 'Manage seller verification',
        },
      ];
    }

    // Common bottom menu items
    final commonItems = [
      {
        'title': 'Help & Support',
        'icon': Icons.help_outline,
        'subtitle': 'Get help and contact support',
      },
      {
        'title': 'Privacy Policy',
        'icon': Icons.privacy_tip_outlined,
        'subtitle': 'Read our privacy policy',
      },
      {
        'title': 'Terms of Service',
        'icon': Icons.description_outlined,
        'subtitle': 'View terms and conditions',
      },
      {
        'title': 'Sign Out',
        'icon': Icons.logout,
        'subtitle': 'Sign out of your account',
        'isDestructive': true,
      },
    ];

    // Combine all menu items
    final allMenuItems = [...baseMenuItems, ...typeSpecificItems, ...commonItems];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // User type badge
          if (user != null) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _getUserTypeGradient(user.userType),
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    _getUserTypeIcon(user.userType),
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${user.userTypeDisplayName} Account',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          _getUserTypeDescription(user.userType),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (user.isSeller && user.isVerifiedSeller == true)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.verified,
                            color: Colors.white,
                            size: 12,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'Verified',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],

          // Menu items
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: allMenuItems.length,
              separatorBuilder: (context, index) => Divider(
                color: AppColors.cardBackground,
                height: 1,
                indent: 60,
              ),
              itemBuilder: (context, index) {
                final item = allMenuItems[index];
                final isDestructive = item['isDestructive'] as bool? ?? false;

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isDestructive
                          ? AppColors.error.withOpacity(0.1)
                          : AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      item['icon'] as IconData,
                      color: isDestructive ? AppColors.error : AppColors.primary,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    item['title'] as String,
                    style: TextStyle(
                      color: isDestructive ? AppColors.error : AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    item['subtitle'] as String,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                  onTap: () {
                    if (isDestructive) {
                      _handleLogout(context);
                    } else {
                      // Handle other menu items
                      _showComingSoon(context, item['title'] as String);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Color> _getUserTypeGradient(UserType userType) {
    switch (userType) {
      case UserType.customer:
        return AppColors.primaryGradient;
      case UserType.salon:
        return AppColors.secondaryGradient;
      case UserType.seller:
        return AppColors.accentGradient;
    }
  }

  IconData _getUserTypeIcon(UserType userType) {
    switch (userType) {
      case UserType.customer:
        return Icons.person;
      case UserType.salon:
        return Icons.store;
      case UserType.seller:
        return Icons.shopping_bag;
    }
  }

  String _getUserTypeDescription(UserType userType) {
    switch (userType) {
      case UserType.customer:
        return 'Book services and shop products';
      case UserType.salon:
        return 'Manage your salon business';
      case UserType.seller:
        return 'Sell beauty and care products';
    }
  }

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: Text(
            'Sign Out',
            style: TextStyle(color: AppColors.textPrimary),
          ),
          content: Text(
            'Are you sure you want to sign out?',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await AuthService().logout();
                // The AuthWrapper will automatically redirect to login
              },
              child: Text(
                'Sign Out',
                style: TextStyle(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature coming soon!'),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}