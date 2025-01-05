import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_clothes/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class TOrderListItem extends StatelessWidget {
  const TOrderListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder:
          (_, index) => TRoundContainer(
            showBorder: true,
            padding: const EdgeInsets.all(TSize.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(Iconsax.ship),
                    SizedBox(width: TSize.spaceBtwItems / 2),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Processing",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),

                          Text(
                            "07 Nov 2024",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      onPressed: () {},
                      icon: Icon(Iconsax.arrow_right_34, size: TSize.iconSm),
                    ),
                  ],
                ),
                const SizedBox(height: TSize.spaceBtwItems),

                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Iconsax.tag),
                          SizedBox(width: TSize.spaceBtwItems / 2),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),

                                Text(
                                  "#45789",
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Iconsax.calendar),
                          SizedBox(width: TSize.spaceBtwItems / 2),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Shipping Date",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),

                                Text(
                                  "03 Feb 2025",
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      separatorBuilder: (_, __) => SizedBox(height: TSize.spaceBtwItems),
      itemCount: 10,
    );
  }
}
