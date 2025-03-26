import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:shop_app_clothes/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:shop_app_clothes/pages/controllers/OrderController.dart';
import 'package:shop_app_clothes/pages/shop/order/widgets/order_list_detail.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class TOrderListItem extends StatelessWidget {


  TOrderListItem({super.key}) {

  }

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
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
                // First Row: Order Status & Date
                Row(
                  children: [
                    Icon(Iconsax.ship, size: 28, color: Colors.blue),
                    SizedBox(width: TSize.spaceBtwItems / 2),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.status,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            formattedDate,
                            style: Theme.of(
                              context,
                            ).textTheme.headlineSmall!.copyWith(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (order.orderItems.isNotEmpty) {
                          // Truyền cả danh sách orderItems vào màn hình chi tiết
                          Get.to(
                            () => OrderItemDetailsScreen(
                              orderItems: order.orderItems,
                            ),
                          );
                        } else {}
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        size: 24,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSize.spaceBtwItems),

                const SizedBox(height: TSize.spaceBtwItems),

                // Second Row: Order ID and Payment Method
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Iconsax.tag, size: 22, color: Colors.green),
                          SizedBox(width: TSize.spaceBtwItems / 2),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order Id",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  "#${order.orderId}",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: TSize.spaceBtwItems),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Iconsax.money, size: 22, color: Colors.orange),
                          SizedBox(width: TSize.spaceBtwItems / 2),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Payment Method",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  order.paymentMethodName,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
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
