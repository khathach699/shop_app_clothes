import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shop_app_clothes/features/shop/models/Rating.dart';
import 'package:shop_app_clothes/features/shop/service/RatingService.dart';

class TRatingBarIndicator extends StatefulWidget {
  const TRatingBarIndicator({super.key, required this.productId});
  final int productId;

  @override
  _TRatingBarIndicatorState createState() => _TRatingBarIndicatorState();
}

class _TRatingBarIndicatorState extends State<TRatingBarIndicator> {
  double _rating = 0;

  // Function to add rating
  Future<void> _submitRating(double rating) async {
    RatingService ratingService = RatingService();
    Rating newRating = Rating(
      userId: 1, // You can replace it with the actual user ID
      productId: widget.productId,
      score: rating.toInt(),
    );

    try {
      // Call the addRating method to save the rating
      await ratingService.addRating(newRating);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Rating added successfully!')));
    } catch (e) {
      // Handle any errors
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to add rating: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Display the RatingBar for the user to choose a rating
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
        // Button to submit the rating
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ), // Smaller padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                6,
              ), // Slightly smaller corner radius
            ),
          ),
          onPressed: () {
            if (_rating > 0) {
              _submitRating(_rating); // Call the function to submit the rating
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please select a rating.')),
              );
            }
          },
          child: Text(
            'Submit Rating',
            style: TextStyle(fontSize: 14), // Smaller text size
          ),
        ),
      ],
    );
  }
}
