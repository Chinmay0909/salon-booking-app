import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/home/header_section.dart';
import '../widgets/home/search_bar_widget.dart';
import '../widgets/explore/specialists_section.dart';
import '../widgets/explore/near_you_section.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();
  Map<String, dynamic>? _appliedFilters;
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderSection(),
              const SizedBox(height: 24),

              // Search Bar with Filter
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SearchBarWidget(
                  controller: _searchController,
                  onSearchChanged: _onSearchChanged,
                  onFiltersApplied: _onFiltersApplied,
                ),
              ),

              const SizedBox(height: 24),

              // Show applied filters summary if any
              if (_appliedFilters != null) _buildFiltersSummary(),

              const SizedBox(height: 24),
              const SpecialistsSection(),
              const SizedBox(height: 32),
              const NearYouSection(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    // TODO: Implement search logic here
    // You can filter your specialists and nearby services based on the search query
    _performSearch(query);
  }

  void _onFiltersApplied(Map<String, dynamic>? filterData) {
    setState(() {
      _appliedFilters = filterData;
    });
    // TODO: Implement filter logic here
    // You can filter your content based on the applied filters
    _applyFilters(filterData);
  }

  Widget _buildFiltersSummary() {
    if (_appliedFilters == null) return const SizedBox.shrink();

    List<String> activeFilters = [];

    // Add location filter
    if (_appliedFilters!['location'] != null && _appliedFilters!['location'] != 'Lisbon') {
      activeFilters.add('📍 ${_appliedFilters!['location']}');
    }

    // Add category filter
    if (_appliedFilters!['category'] != null && _appliedFilters!['category'] != 'All') {
      activeFilters.add('🏷️ ${_appliedFilters!['category']}');
    }

    // Add distance filter
    if (_appliedFilters!['distance'] != null && _appliedFilters!['distance'] != 'All') {
      activeFilters.add('📏 ${_appliedFilters!['distance']}');
    }

    // Add ratings filter
    if (_appliedFilters!['ratings'] != null && _appliedFilters!['ratings'].isNotEmpty) {
      List<int> ratings = List<int>.from(_appliedFilters!['ratings']);
      if (ratings.isNotEmpty) {
        ratings.sort((a, b) => b.compareTo(a));
        activeFilters.add('⭐ ${ratings.join(', ')}+ stars');
      }
    }

    if (activeFilters.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Active Filters:',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: _clearAllFilters,
                child: Text(
                  'Clear All',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: activeFilters.map((filter) => _buildFilterChip(filter)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String filter) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Text(
        filter,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _clearAllFilters() {
    setState(() {
      _appliedFilters = null;
    });
    // TODO: Reset the filtered content to show all items
    _applyFilters(null);
  }

  void _performSearch(String query) {
    // TODO: Implement your search logic here
    // This is where you would filter your specialists and nearby services
    // based on the search query

    print('Searching for: $query');

    // Example implementation:
    // - Filter specialists by name, service type, etc.
    // - Filter nearby services by name, category, etc.
    // - Update the UI to show filtered results
  }

  void _applyFilters(Map<String, dynamic>? filters) {
    // TODO: Implement your filter logic here
    // This is where you would filter your content based on the applied filters

    print('Applied filters: $filters');

    // Example implementation:
    // - Filter by location (if not default)
    // - Filter by category (if not 'All')
    // - Filter by distance
    // - Filter by ratings
    // - Update both SpecialistsSection and NearYouSection with filtered data
  }
}