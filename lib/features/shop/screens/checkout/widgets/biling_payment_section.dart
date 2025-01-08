import 'package:flutter/material.dart';
import 'package:shop_app_clothes/common/widgets/texts/section_heading.dart';
import 'package:shop_app_clothes/features/shop/screens/checkout/widgets/select_option_payment.dart';

class TBillingPaymentSection extends StatefulWidget {
  const TBillingPaymentSection({super.key});

  @override
  State<TBillingPaymentSection> createState() => _TBillingPaymentSectionState();
}

class _TBillingPaymentSectionState extends State<TBillingPaymentSection> {
  String _selectedPaymentMethod = "Paypal"; // Phương thức mặc định

  void _selectPaymentMethod() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectOptionPayment()),
    );
    if (result != null) {
      setState(() {
        _selectedPaymentMethod = result; // Cập nhật phương thức thanh toán
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TSectionHeading(
          title: "Payment Method",
          buttonTitle: "Change",
          onPressed: _selectPaymentMethod, // Mở màn hình chọn phương thức
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Icon(Icons.payment, size: 24, color: Colors.deepPurple),
            const SizedBox(width: 16),
            Text(
              _selectedPaymentMethod,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ],
    );
  }
}
