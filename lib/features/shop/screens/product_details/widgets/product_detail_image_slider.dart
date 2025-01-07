import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:shop_app_clothes/common/widgets/appbar/appbar.dart';
import 'package:shop_app_clothes/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:shop_app_clothes/common/widgets/icons/t_circular_icon.dart';
import 'package:shop_app_clothes/common/widgets/images/t_roundted_image.dart';
import 'package:shop_app_clothes/utils/constants/colors.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';
import 'package:get_storage/get_storage.dart';
import '../../../controllers/WishlistController.dart';
import '../../../models/Product.dart';
import '../../service/WishlistService.dart';

class TProductImageSlider extends StatefulWidget {
  final Product product;
  const TProductImageSlider({
    super.key,
    required this.dark,
    required this.product,
  });

  final bool dark;

  @override
  State<TProductImageSlider> createState() => _TProductImageSliderState();
}

class _TProductImageSliderState extends State<TProductImageSlider> {
  late WishlistController _wishlistController;

  @override
  void initState() {
    super.initState();
    _wishlistController = Get.put(WishlistController());
    _checkIfInWishlist();
  }

  _checkIfInWishlist() async {
    final box = GetStorage();
    int? userId = box.read('userId');
    if (userId != null) {
      // Kiểm tra trạng thái wishlist ban đầu mà không thay đổi gì
      await _wishlistController.checkIfInWishlist(userId, widget.product.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TCurveEdgeWidget(
      child: Container(
        color: widget.dark ? TColors.darkGrey : TColors.light,
        child: Stack(
          children: [
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(TSize.productImageRadius * 2),
                child: Image(image: NetworkImage(widget.product.image)),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 30,
              left: TSize.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (_, index) => TRoundedImage(
                    imageUrl: widget.product.image,
                    width: 80,
                    backgroundColor: widget.dark ? TColors.dart : TColors.light, // Keep it as is, no change in background
                    border: Border.all(color: TColors.primaryColor),
                    padding: const EdgeInsets.all(TSize.sm),
                  ),
                  separatorBuilder: (_, __) => const SizedBox(width: TSize.spaceBtwItems),
                  itemCount: 6,
                ),
              ),
            ),
            TAppBar(
              showBackArrow: true,
              actions: [
                Obx(() {
                  return TCircularIcon(
                    icon: _wishlistController.isInWishlist.value
                        ? Iconsax.heart5
                        : Iconsax.heart,
                    color: _wishlistController.isInWishlist.value
                        ? Colors.red
                        : Colors.grey,
                    onPressed: () async {
                      final box = GetStorage();
                      int? userId = box.read('userId');
                      if (userId != null) {
                        // Toggle wishlist when the button is pressed
                        await _wishlistController.toggleWishlist(userId, widget.product.id);
                      }
                    },
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

}