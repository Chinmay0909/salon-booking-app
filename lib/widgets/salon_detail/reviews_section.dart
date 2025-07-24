// widgets/salon_detail/reviews_section.dart

import 'package:flutter/material.dart';
import '../../models/salon_model.dart';
import '../../utils/app_colors.dart';

class ReviewsSection extends StatefulWidget {
  final List<ReviewModel> reviews;
  final double averageRating;
  final int? maxItemsToShow;

  const ReviewsSection({
    super.key,
    required this.reviews,
    required this.averageRating,
    this.maxItemsToShow,
  });

  @override
  State<ReviewsSection> createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends State<ReviewsSection> {
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    final int maxItems = widget.maxItemsToShow ?? 3;
    final List<ReviewModel> displayReviews = _showAll
        ? widget.reviews
        : widget.reviews.take(maxItems).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Rating Summary
        _buildRatingSummary(),
        const SizedBox(height: 20),

        // Reviews List
        ...displayReviews.asMap().entries.map((entry) {
          final index = entry.key;
          final review = entry.value;
          return Padding(
            padding: EdgeInsets.only(bottom: index < displayReviews.length - 1 ? 16 : 0),
            child: _buildReviewCard(review),
          );
        }).toList(),

        // Show More/Less Button
        if (widget.reviews.length > maxItems) ...[
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
                _showAll ? 'Show Less' : 'Show All Reviews (${widget.reviews.length})',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],

        const SizedBox(height: 20),

        // Write Review Button
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton.icon(
            onPressed: _showWriteReviewDialog,
            icon: Icon(
              Icons.edit,
              color: AppColors.primary,
              size: 20,
            ),
            label: Text(
              'Write a Review',
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
    );
  }

  Widget _buildRatingSummary() {
    // Calculate rating distribution
    Map<int, int> ratingCounts = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (var review in widget.reviews) {
      ratingCounts[review.rating.round()] = (ratingCounts[review.rating.round()] ?? 0) + 1;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Overall Rating
          Row(
            children: [
              // Rating Number
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.averageRating.toStringAsFixed(1),
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        Icons.star,
                        color: index < widget.averageRating
                            ? Colors.amber
                            : AppColors.textSecondary.withOpacity(0.3),
                        size: 20,
                      );
                    }),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.reviews.length} reviews',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 32),

              // Rating Bars
              Expanded(
                child: Column(
                  children: List.generate(5, (index) {
                    final star = 5 - index;
                    final count = ratingCounts[star] ?? 0;
                    final percentage = widget.reviews.isNotEmpty
                        ? count / widget.reviews.length
                        : 0.0;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          Text(
                            '$star',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 14,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: percentage,
                              backgroundColor: AppColors.textSecondary.withOpacity(0.1),
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                              minHeight: 6,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '$count',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(ReviewModel review) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.textSecondary.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Review Header
          Row(
            children: [
              // Customer Avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(review.customerImageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Customer Info and Rating
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.customerName,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        // Star Rating
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              Icons.star,
                              color: index < review.rating
                                  ? Colors.amber
                                  : AppColors.textSecondary.withOpacity(0.3),
                              size: 14,
                            );
                          }),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _formatReviewDate(review.date),
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

              // Rating Score
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getRatingColor(review.rating).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  review.rating.toString(),
                  style: TextStyle(
                    color: _getRatingColor(review.rating),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Review Comment
          Text(
            review.comment,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),

          // Review Actions
          Row(
            children: [
              // Helpful Button
              GestureDetector(
                onTap: () => _markAsHelpful(review.id),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.textSecondary.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.thumb_up_outlined,
                        color: AppColors.textSecondary,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Helpful',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Reply Button (for salon owner)
              GestureDetector(
                onTap: () => _replyToReview(review.id),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.textSecondary.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.reply,
                        color: AppColors.textSecondary,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Reply',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getRatingColor(double rating) {
    if (rating >= 4.0) return Colors.green;
    if (rating >= 3.0) return Colors.orange;
    return Colors.red;
  }

  String _formatReviewDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else {
      return '${(difference.inDays / 30).floor()} months ago';
    }
  }

  void _markAsHelpful(String reviewId) {
    // TODO: Implement mark as helpful functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Marked as helpful'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _replyToReview(String reviewId) {
    // TODO: Implement reply to review functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Reply to review feature'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _showWriteReviewDialog() {
    double userRating = 5.0;
    final TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: AppColors.background,
          title: Text(
            'Write a Review',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rating Selection
              Text(
                'Rate your experience:',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        userRating = (index + 1).toDouble();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Icon(
                        Icons.star,
                        color: index < userRating ? Colors.amber : Colors.grey[300],
                        size: 32,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),

              // Comment Field
              Text(
                'Share your experience:',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: commentController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Tell others about your experience...',
                  hintStyle: TextStyle(color: AppColors.textSecondary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _submitReview(userRating, commentController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: const Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitReview(double rating, String comment) {
    // TODO: Implement review submission
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Review submitted successfully!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}