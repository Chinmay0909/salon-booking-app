// screens/home/bookmarks_screen.dart
import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  // Sample data - replace with your actual data source
  final List<BookmarkedShop> bookmarkedShops = [
    BookmarkedShop(
      id: '1',
      name: 'Captains Barbershop',
      address: 'KK 15 AVE Street, Kigali, RW',
      distance: '1.2 km',
      rating: '4.8',
      imageUrl: 'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?w=400',
    ),
    BookmarkedShop(
      id: '2',
      name: 'Captains Barbershop',
      address: 'KK 15 AVE Street, Kigali, RW',
      distance: '1.2 km',
      rating: '4.8',
      imageUrl: 'https://images.unsplash.com/photo-1622296089863-eb7fc530daa0?w=400',
    ),
    BookmarkedShop(
      id: '3',
      name: 'Captains Barbershop',
      address: 'KK 15 AVE Street, Kigali, RW',
      distance: '1.2 km',
      rating: '4.8',
      imageUrl: 'https://images.unsplash.com/photo-1599351431202-1e0f0137899a?w=400',
    ),
    BookmarkedShop(
      id: '4',
      name: 'Captains Barbershop',
      address: 'KK 15 AVE Street, Kigali, RW',
      distance: '1.2 km',
      rating: '4.8',
      imageUrl: 'https://images.unsplash.com/photo-1584362917165-526a968579e8?w=400',
    ),
    BookmarkedShop(
      id: '5',
      name: 'Captains Barbershop',
      address: 'KK 15 AVE Street, Kigali, RW',
      distance: '1.2 km',
      rating: '4.8',
      imageUrl: 'https://images.unsplash.com/photo-1605497788044-5a32c7078486?w=400',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.textPrimary,
            size: 24,
          ),
        ),
        title: Text(
          'My Bookmarks',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Handle search functionality
            },
            icon: Icon(
              Icons.search,
              color: AppColors.textPrimary,
              size: 24,
            ),
          ),
        ],
      ),
      body: bookmarkedShops.isEmpty
          ? _buildEmptyState()
          : _buildBookmarksList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_outline,
            size: 80,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            'No Bookmarks Yet',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start bookmarking your favorite\nbarbershops and salons',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookmarksList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bookmarkedShops.length,
      itemBuilder: (context, index) {
        return _buildBookmarkItem(bookmarkedShops[index], index);
      },
    );
  }

  Widget _buildBookmarkItem(BookmarkedShop shop, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Shop Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(shop.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Shop Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shop.name,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  shop.address,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppColors.primary,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      shop.distance,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      shop.rating,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Bookmark Icon
          GestureDetector(
            onTap: () => _removeBookmark(index),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.bookmark,
                color: AppColors.primary,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _removeBookmark(int index) {
    setState(() {
      bookmarkedShops.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Removed from bookmarks'),
        backgroundColor: AppColors.surface,
        action: SnackBarAction(
          label: 'Undo',
          textColor: AppColors.primary,
          onPressed: () {
            // Implement undo functionality if needed
          },
        ),
      ),
    );
  }
}

// Model class for bookmarked shops
class BookmarkedShop {
  final String id;
  final String name;
  final String address;
  final String distance;
  final String rating;
  final String imageUrl;

  BookmarkedShop({
    required this.id,
    required this.name,
    required this.address,
    required this.distance,
    required this.rating,
    required this.imageUrl,
  });
}