import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import 'filter_page.dart'; // Adjust the import path based on your project structure

class SearchBarWidget extends StatelessWidget {
  final Function(Map<String, dynamic>?)? onFiltersApplied;
  final TextEditingController? controller;
  final Function(String)? onSearchChanged;

  const SearchBarWidget({
    super.key,
    this.onFiltersApplied,
    this.controller,
    this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Icon(
            Icons.search,
            color: AppColors.textSecondary,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onSearchChanged,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _openFilterPage(context),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.tune,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openFilterPage(BuildContext context) async {
    final filterData = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => const FilterPage(),
      ),
    );

    // Call the callback function with the filter data if provided
    if (onFiltersApplied != null) {
      onFiltersApplied!(filterData);
    }
  }
}