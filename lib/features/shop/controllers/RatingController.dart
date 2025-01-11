import 'package:get/get.dart';
import 'package:shop_app_clothes/features/shop/service/RatingService.dart';

class RatingController extends GetxController {
  var totalRatings = 0.obs; // Observable variable to store total ratings

  // Fetch total ratings from the API
  Future<void> getTotalRatings(int productId) async {
    RatingService ratingService = RatingService();
    try {
      int total = await ratingService.getTotalRatings(productId);
      totalRatings.value = total; // Update the observable variable
    } catch (e) {
      totalRatings.value = 0; // Default to 0 if error occurs
      print('Error fetching total ratings: $e');
    }
  }
}
