// widgets/salon_detail/services_list.dart

import 'package:flutter/material.dart';
import '../../models/salon_model.dart';
import '../../utils/app_colors.dart';

class ServicesList extends StatefulWidget {
  final List<ServiceModel> services;
  final int? maxItemsToShow;

  const ServicesList({
    super.key,
    required this.services,
    this.maxItemsToShow,
  });

  @override
  State<ServicesList> createState() => _ServicesListState();
}

class _ServicesListState extends State<ServicesList> {
  bool _showAll = false;
  Set<String> _selectedServices = <String>{};

  @override
  Widget build(BuildContext context) {
    final int maxItems = widget.maxItemsToShow ?? 3;
    final List<ServiceModel> displayServices = _showAll
        ? widget.services
        : widget.services.take(maxItems).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Services List
        ...displayServices.asMap().entries.map((entry) {
          final index = entry.key;
          final service = entry.value;
          return Padding(
            padding: EdgeInsets.only(bottom: index < displayServices.length - 1 ? 12 : 0),
            child: _buildServiceCard(service),
          );
        }).toList(),

        // Show More/Less Button
        if (widget.services.length > maxItems) ...[
          const SizedBox(height: 16),
          Center(
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  _showAll = !_showAll;
                });
              },
              icon: Icon(
                _showAll ? Icons.expand_less : Icons.expand_more,
                color: AppColors.primary,
                size: 20,
              ),
              label: Text(
                _showAll ? 'Show Less' : 'Show All (${widget.services.length})',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],

        // Book Selected Services Button
        if (_selectedServices.isNotEmpty) ...[
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _bookSelectedServices,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                'Book ${_selectedServices.length} Service${_selectedServices.length > 1 ? 's' : ''} - \$${_calculateTotalPrice()}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildServiceCard(ServiceModel service) {
    final bool isSelected = _selectedServices.contains(service.id);

    return GestureDetector(
      onTap: () => _toggleServiceSelection(service.id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.1)
              : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.textSecondary.withOpacity(0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Icon/Image
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withOpacity(0.2)
                    : AppColors.textSecondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: service.imageUrl != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  service.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => _buildServiceIcon(service),
                ),
              )
                  : _buildServiceIcon(service),
            ),
            const SizedBox(width: 16),

            // Service Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Service Name and Selection Icon
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          service.name,
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Description
                  Text(
                    service.description,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),

                  // Price and Duration
                  Row(
                    children: [
                      // Price
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '\$${service.price}',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Duration
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: AppColors.textSecondary,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${service.duration} min',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),

                      // Quick Book Button
                      GestureDetector(
                        onTap: () => _quickBookService(service),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.primary),
                          ),
                          child: Text(
                            'Book',
                            style: TextStyle(
                              color: isSelected ? Colors.white : AppColors.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
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
    );
  }

  Widget _buildServiceIcon(ServiceModel service) {
    IconData icon;
    Color iconColor;

    // Determine icon based on service name/type
    switch (service.name.toLowerCase()) {
      case 'hair cut':
      case 'haircut':
        icon = Icons.content_cut;
        iconColor = Colors.orange;
        break;
      case 'beard trim':
      case 'shave':
        icon = Icons.face;
        iconColor = Colors.blue;
        break;
      case 'hair wash':
      case 'shampoo':
        icon = Icons.water_drop;
        iconColor = Colors.lightBlue;
        break;
      case 'styling':
      case 'hair style':
        icon = Icons.brush;
        iconColor = Colors.purple;
        break;
      case 'massage':
        icon = Icons.spa;
        iconColor = Colors.green;
        break;
      default:
        icon = Icons.stars;
        iconColor = AppColors.primary;
    }

    return Icon(
      icon,
      color: iconColor,
      size: 24,
    );
  }

  void _toggleServiceSelection(String serviceId) {
    setState(() {
      if (_selectedServices.contains(serviceId)) {
        _selectedServices.remove(serviceId);
      } else {
        _selectedServices.add(serviceId);
      }
    });
  }

  void _quickBookService(ServiceModel service) {
    // Clear other selections and select only this service
    setState(() {
      _selectedServices.clear();
      _selectedServices.add(service.id);
    });

    // Show booking confirmation
    _showBookingConfirmation(service);
  }

  void _bookSelectedServices() {
    final selectedServicesList = widget.services
        .where((service) => _selectedServices.contains(service.id))
        .toList();

    _showMultiServiceBooking(selectedServicesList);
  }

  double _calculateTotalPrice() {
    return widget.services
        .where((service) => _selectedServices.contains(service.id))
        .fold(0.0, (total, service) => total + service.price);
  }

  int _calculateTotalDuration() {
    return widget.services
        .where((service) => _selectedServices.contains(service.id))
        .fold(0, (total, service) => total + service.duration);
  }

  void _showBookingConfirmation(ServiceModel service) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Book ${service.name}?',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Price: \$${service.price} • Duration: ${service.duration} min',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // TODO: Navigate to booking screen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    child: const Text('Book Now'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMultiServiceBooking(List<ServiceModel> services) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Book Selected Services',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),

            // Services summary
            Expanded(
              child: ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(service.name),
                        Text('\$${service.price}'),
                      ],
                    ),
                  );
                },
              ),
            ),

            const Divider(),

            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: ${_calculateTotalDuration()} min',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '\$${_calculateTotalPrice()}',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // TODO: Navigate to booking screen with selected services
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: const Text('Continue to Booking'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}