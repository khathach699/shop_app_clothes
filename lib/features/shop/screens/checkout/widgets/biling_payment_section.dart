import 'package:flutter/material.dart';
import 'package:shop_app_clothes/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:shop_app_clothes/common/widgets/texts/section_heading.dart';
import 'package:shop_app_clothes/utils/constants/image_strings.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class TBillingPaymentSection extends StatelessWidget {
  const TBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TSectionHeading(
          title: "Payment Method",
          buttonTitle: "Change",
          onPressed: () {},
        ),
        const SizedBox(height: TSize.spaceBtwItems / 2),

        Row(
          children: [
            TRoundContainer(
              width: 60,
              height: 35,
              padding: const EdgeInsets.all(TSize.sm),
              child: const Image(
                image: AssetImage(TImages.facebook),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: TSize.spaceBtwItems / 2),
            Text("Paypal", style: Theme.of(context).textTheme.bodyLarge),

            TRoundContainer(
              width: 60,
              height: 35,
              padding: const EdgeInsets.all(TSize.sm),
              child: const Image(
                image: AssetImage(TImages.facebook),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: TSize.spaceBtwItems / 2),
            Text("Money", style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ],
    );
  }
}
