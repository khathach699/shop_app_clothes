import 'package:flutter/material.dart';
import 'package:shop_app_clothes/common/widgets/appbar/appbar.dart';
import 'package:shop_app_clothes/features/shop/screens/order/widgets/order_list_item.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "My Order",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: TOrderListItem(),
    );
  }
}
