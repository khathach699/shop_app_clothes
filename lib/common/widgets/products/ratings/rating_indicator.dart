import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shop_app_clothes/features/shop/models/Rating.dart';
import 'package:shop_app_clothes/features/shop/service/RatingService.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class TRatingBarIndicator extends StatefulWidget {
  const TRatingBarIndicator({
    Key? key,
    required this.productId,
    required this.onRatingSubmitted,
  }) : super(key: key);

  final int productId;
  final VoidCallback onRatingSubmitted; // Callback function

  @override
  _TRatingBarIndicatorState createState() => _TRatingBarIndicatorState();
}

class _TRatingBarIndicatorState extends State<TRatingBarIndicator> {
  double _rating = 0;

  Future<void> _submitRating(double rating) async {
    RatingService ratingService = RatingService();
    Rating newRating = Rating(
      userId: 1, // Replace with actual user ID
      productId: widget.productId,
      score: rating.toInt(),
    );

    try {
      await ratingService.addRating(newRating);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Rating added successfully!')));
      widget.onRatingSubmitted(); // Call the callback to refresh data
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to add rating: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RatingBar.builder(
          initialRating: _rating,
          minRating: 1,
          direction: Axis.horizontal,
          itemCount: 5,
          itemSize: 18,
          itemPadding: EdgeInsets.symmetric(horizontal: 4),
          itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
        ),
        SizedBox(width: TSize.spaceBtwItems / 2),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          onPressed: () {
            if (_rating > 0) {
              _submitRating(_rating);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please select a rating.')),
              );
            }
          },
          child: Text('Submit Rating', style: TextStyle(fontSize: 14)),
        ),
      ],
    );
  }
}
