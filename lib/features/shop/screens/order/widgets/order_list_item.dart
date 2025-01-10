import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:shop_app_clothes/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:shop_app_clothes/features/shop/controllers/OrderController.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class TOrderListItem extends StatelessWidget {
  final OrderController orderController = Get.put(OrderController());

  TOrderListItem({super.key}) {
    orderController.fetchOrders(); // Gọi hàm khi widget được tạo
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (orderController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      if (orderController.orders.isEmpty) {
        return Center(child: Text("No orders found."));
      }
      return ListView.separated(
        itemBuilder: (_, index) {
          final order = orderController.orders[index];
          String formattedDate = DateFormat(
            'dd/MM/yyyy',
          ).format(DateTime.parse(order.createdAt));
          return TRoundContainer(
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
                            order.status,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            formattedDate,
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
                                  "Order Id",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  "#${order.orderId}",
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
                          Icon(Iconsax.money),
                          SizedBox(width: TSize.spaceBtwItems / 2),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Payment Method",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  order.paymentMethodName,
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
          );
        },
        separatorBuilder: (_, __) => SizedBox(height: TSize.spaceBtwItems),
        itemCount: orderController.orders.length,
      );
    });
  }
}
