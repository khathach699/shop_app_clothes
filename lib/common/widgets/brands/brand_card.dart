import 'package:flutter/material.dart';
import 'package:shop_app_clothes/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:shop_app_clothes/common/widgets/images/t_circular_Image.dart';
import 'package:shop_app_clothes/common/widgets/texts/branch_title_with_verified_icon.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class BrandCard extends StatelessWidget {
  final String title;
  final String image;
  final int productCount;
  final VoidCallback? onTap;

  const BrandCard({
    super.key,
    required this.title, // Tên thương hiệu
    required this.image, // Hình ảnh thương hiệu
    this.productCount = 0, // Số lượng sản phẩm
    this.onTap, // Hàm xử lý khi nhấn
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TRoundContainer(
        padding: const EdgeInsets.all(TSize.sm),
        showBorder: true,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            Flexible(
              child: TCircularImage(
                isNetworkImage: true,
                image: image,
                backgroundColor: Colors.transparent,
              ),
            ),
            const SizedBox(width: TSize.spaceBtwItems / 2),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TBrandTitleWithVerifiedIcon(title: title),
                  Text(
                    "$productCount products",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
