import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class SalonServicesScreen extends StatefulWidget {
  const SalonServicesScreen({super.key});

  @override
  State<SalonServicesScreen> createState() => _SalonServicesScreenState();
}

class _SalonServicesScreenState extends State<SalonServicesScreen> {
  final List<Map<String, dynamic>> _services = [
    {
      'name': 'Hair Cut',
      'description': 'Professional hair cutting service',
      'duration': '45 min',
      'price': 25.0,
      'category': 'Hair',
      'isActive': true,
      'bookings': 45,
    },
    {
      'name': 'Hair Styling',
      'description': 'Creative hair styling and blow-dry',
      'duration': '60 min',
      'price': 35.0,
      'category': 'Hair',
      'isActive': true,
      'bookings': 32,
    },
    {
      'name': 'Hair Coloring',
      'description': 'Professional hair coloring service',
      'duration': '120 min',
      'price': 85.0,
      'category': 'Hair',
      'isActive': true,
      'bookings': 18,
    },
    {
      'name': 'Facial Treatment',
      'description': 'Deep cleansing facial treatment',
      'duration': '90 min',
      'price': 55.0,
      'category': 'Facial',
      'isActive': true,
      'bookings': 28,
    },
    {
      'name': 'Manicure',
      'description': 'Professional nail care and polish',
      'duration': '45 min',
      'price': 20.0,
      'category': 'Nails',
      'isActive': true,
      'bookings': 67,
    },
    {
      'name': 'Pedicure',
      'description': 'Foot care and nail polish service',
      'duration': '60 min',
      'price': 30.0,
      'category': 'Nails',
      'isActive': false,
      'bookings': 15,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildStatsRow(),
            Expanded(
              child: _buildServicesList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddServiceDialog,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
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
                  'Services & Pricing',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Manage your salon services and pricing',
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
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.search,
                  color: AppColors.textPrimary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.sort,
                  color: AppColors.textPrimary,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    final activeServices = _services.where((s) => s['isActive']).length;
    final totalBookings = _services.fold<int>(0, (sum, s) => sum + (s['bookings'] as int));
    final avgPrice = _services.where((s) => s['isActive']).fold<double>(0, (sum, s) => sum + s['price']) / activeServices;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Active Services',
              activeServices.toString(),
              Icons.check_circle,
              AppColors.success,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'Total Bookings',
              totalBookings.toString(),
              Icons.calendar_today,
              AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'Avg. Price',
              '\$${avgPrice.toStringAsFixed(0)}',
              Icons.attach_money,
              AppColors.secondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildServicesList() {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: _services.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final service = _services[index];
        return _buildServiceCard(service, index);
      },
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service, int index) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: service['isActive']
            ? null
            : Border.all(color: AppColors.textSecondary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service['name'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: service['isActive']
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      service['description'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: service['isActive'],
                onChanged: (value) {
                  setState(() {
                    _services[index]['isActive'] = value;
                  });
                },
                activeColor: AppColors.primary,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildServiceDetail(
                Icons.access_time,
                service['duration'],
                AppColors.secondary,
              ),
              const SizedBox(width: 16),
              _buildServiceDetail(
                Icons.attach_money,
                '\$${service['price']}',
                AppColors.success,
              ),
              const SizedBox(width: 16),
              _buildServiceDetail(
                Icons.bookmark,
                '${service['bookings']} bookings',
                AppColors.accent,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getCategoryColor(service['category']).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  service['category'],
                  style: TextStyle(
                    fontSize: 10,
                    color: _getCategoryColor(service['category']),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: AppColors.textSecondary,
                  size: 18,
                ),
                onPressed: () => _showEditServiceDialog(service, index),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: AppColors.error,
                  size: 18,
                ),
                onPressed: () => _showDeleteConfirmation(index),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceDetail(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 14),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 11,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Hair':
        return AppColors.primary;
      case 'Facial':
        return AppColors.secondary;
      case 'Nails':
        return AppColors.accent;
      default:
        return AppColors.textSecondary;
    }
  }

  void _showAddServiceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          'Add New Service',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: Text(
          'Service creation form coming soon!',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditServiceDialog(Map<String, dynamic> service, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          'Edit ${service['name']}',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: Text(
          'Service editing form coming soon!',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          'Delete Service',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: Text(
          'Are you sure you want to delete this service?',
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
            onPressed: () {
              setState(() {
                _services.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: Text(
              'Delete',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}