import 'package:flutter/material.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Sub total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Subtotal:", style: Theme.of(context).textTheme.bodyMedium),
            Text("\$256:", style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        SizedBox(height: TSize.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Shipping :", style: Theme.of(context).textTheme.bodyMedium),
            Text("Free:", style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        SizedBox(height: TSize.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Tax Fee:", style: Theme.of(context).textTheme.bodyMedium),
            Text("\$6:", style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        SizedBox(height: TSize.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Subtotal:", style: Theme.of(context).textTheme.bodyMedium),
            Text("\$256:", style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }
}
