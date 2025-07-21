import 'package:flutter/material.dart';
import 'dart:async';
import '../../utils/app_colors.dart';

class PromoBanner extends StatefulWidget {
  const PromoBanner({super.key});

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<BannerData> _banners = [
    BannerData(
      title: 'Only Today',
      mainText: '30% OFF',
      description: 'Get a discount on every service\nyou book',
      buttonText: 'Book Now',
      imageUrl: 'https://images.unsplash.com/photo-1560066984-138dadb4c035?w=200&h=200&fit=crop&crop=center',
      gradient: AppColors.primaryGradient,
      textColor: Colors.white,
    ),
    BannerData(
      title: 'Special Offer',
      mainText: 'Buy 2 Get 1',
      description: 'Amazing deals on premium\nbeauty products',
      buttonText: 'Shop Now',
      imageUrl: 'https://images.unsplash.com/photo-1596755389378-c31d21fd1273?w=200&h=200&fit=crop&crop=center',
      gradient: AppColors.secondaryGradient,
      textColor: Colors.white,
    ),
    BannerData(
      title: 'Weekend Deal',
      mainText: 'Free Delivery',
      description: 'On all orders above \$50\nthis weekend only',
      buttonText: 'Order Now',
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200&h=200&fit=crop&crop=center',
      gradient: AppColors.accentGradient,
      textColor: AppColors.textPrimary,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentPage < _banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTapDown: (_) => _pauseAutoSlide(),
              onTapUp: (_) => _resumeAutoSlide(),
              onTapCancel: () => _resumeAutoSlide(),
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _banners.length,
                itemBuilder: (context, index) {
                  return _buildBanner(_banners[index]);
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          _buildPageIndicator(),
        ],
      ),
    );
  }

  void _pauseAutoSlide() {
    _timer?.cancel();
  }

  void _resumeAutoSlide() {
    _startAutoSlide();
  }

  Widget _buildBanner(BannerData banner) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: banner.gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Background image on the right
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              child: Image.network(
                banner.imageUrl,
                width: 120,
                height: 180,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 120,
                    height: 180,
                    color: Colors.grey.shade300,
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                      size: 40,
                    ),
                  );
                },
              ),
            ),
          ),

          // Content overlay
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        banner.title,
                        style: TextStyle(
                          color: banner.textColor.withOpacity(0.9),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        banner.mainText,
                        style: TextStyle(
                          color: banner.textColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        banner.description,
                        style: TextStyle(
                          color: banner.textColor.withOpacity(0.9),
                          fontSize: 13,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle different button actions based on banner type
                        _handleBannerAction(banner);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: banner.textColor == Colors.white
                            ? Colors.white
                            : AppColors.surface,
                        foregroundColor: banner.textColor == Colors.white
                            ? banner.gradient.first
                            : banner.textColor,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size(0, 36),
                      ),
                      child: Text(
                        banner.buttonText,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
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

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_banners.length, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? AppColors.primary
                : AppColors.textSecondary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  void _handleBannerAction(BannerData banner) {
    // Handle different actions based on banner type
    switch (banner.buttonText) {
      case 'Book Now':
      // Navigate to booking screen or show booking dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Redirecting to booking...'),
            backgroundColor: AppColors.primary,
          ),
        );
        break;
      case 'Shop Now':
      // Navigate to products screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Redirecting to shop...'),
            backgroundColor: AppColors.secondary,
          ),
        );
        break;
      case 'Order Now':
      // Navigate to order screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Redirecting to orders...'),
            backgroundColor: AppColors.accent,
          ),
        );
        break;
    }
  }
}

class BannerData {
  final String title;
  final String mainText;
  final String description;
  final String buttonText;
  final String imageUrl;
  final List<Color> gradient;
  final Color textColor;

  BannerData({
    required this.title,
    required this.mainText,
    required this.description,
    required this.buttonText,
    required this.imageUrl,
    required this.gradient,
    required this.textColor,
  });
}