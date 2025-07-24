// widgets/salon_detail/gallery_section.dart

import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class GallerySection extends StatelessWidget {
  final List<String> images;
  final int? maxItemsToShow;

  const GallerySection({
    super.key,
    required this.images,
    this.maxItemsToShow,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const SizedBox.shrink();

    final int maxItems = maxItemsToShow ?? 6;
    final List<String> displayImages = images.take(maxItems).toList();
    final int remainingCount = images.length - maxItems;

    return Column(
      children: [
        // Grid Layout
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemCount: displayImages.length,
          itemBuilder: (context, index) {
            final isLastItem = index == displayImages.length - 1;
            final showOverlay = isLastItem && remainingCount > 0;

            return GestureDetector(
              onTap: () => _openGalleryViewer(context, index),
              child: _buildGalleryItem(
                displayImages[index],
                showOverlay: showOverlay,
                remainingCount: remainingCount,
              ),
            );
          },
        ),

        // View All Button
        if (images.length > maxItems) ...[
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton.icon(
              onPressed: () => _openFullGallery(context),
              icon: Icon(
                Icons.photo_library,
                color: AppColors.primary,
                size: 20,
              ),
              label: Text(
                'View All Photos (${images.length})',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildGalleryItem(
      String imageUrl, {
        bool showOverlay = false,
        int remainingCount = 0,
      }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.image_not_supported,
                  color: AppColors.textSecondary,
                  size: 32,
                ),
              ),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 2,
                    ),
                  ),
                );
              },
            ),
          ),

          // Overlay for remaining count
          if (showOverlay)
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '+$remainingCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _openGalleryViewer(BuildContext context, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryViewerScreen(
          images: images,
          initialIndex: initialIndex,
        ),
      ),
    );
  }

  void _openFullGallery(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullGalleryScreen(images: images),
      ),
    );
  }
}

// Full Screen Gallery Viewer
class GalleryViewerScreen extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const GalleryViewerScreen({
    super.key,
    required this.images,
    this.initialIndex = 0,
  });

  @override
  State<GalleryViewerScreen> createState() => _GalleryViewerScreenState();
}

class _GalleryViewerScreenState extends State<GalleryViewerScreen> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          '${_currentIndex + 1} of ${widget.images.length}',
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: _shareImage,
            icon: const Icon(Icons.share, color: Colors.white),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Image PageView
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: Center(
                  child: Image.network(
                    widget.images[index],
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(
                        Icons.broken_image,
                        color: Colors.white,
                        size: 64,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Navigation dots
          if (widget.images.length > 1)
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.images.asMap().entries.map((entry) {
                  return Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == entry.key
                          ? Colors.white
                          : Colors.white.withOpacity(0.4),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  void _shareImage() {
    // TODO: Implement share image functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Share image functionality'),
        backgroundColor: Colors.black87,
      ),
    );
  }
}

// Full Gallery Grid Screen
class FullGalleryScreen extends StatelessWidget {
  final List<String> images;

  const FullGalleryScreen({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        title: Text(
          'Gallery (${images.length})',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemCount: images.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _openImageViewer(context, index),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    images[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.cardBackground,
                      child: Icon(
                        Icons.broken_image,
                        color: AppColors.textSecondary,
                        size: 48,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _openImageViewer(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryViewerScreen(
          images: images,
          initialIndex: index,
        ),
      ),
    );
  }
}