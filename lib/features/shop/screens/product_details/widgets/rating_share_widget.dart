import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class TRateAndShare extends StatelessWidget {
  const TRateAndShare({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Iconsax.star5, color: Colors.yellow, size: 24),
            const SizedBox(width: TSize.spaceBtwItems / 2),
            Text.rich(
              TextSpan(
                text: '4.5',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: ' (23 reviews)',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Share Icon
        IconButton(onPressed: () {}, icon: const Icon(Icons.share, size: 24)),
      ],
    );
  }
}
