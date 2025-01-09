import 'package:flutter/material.dart';
import 'package:shop_app_clothes/common/widgets/texts/section_heading.dart';
import 'package:shop_app_clothes/features/shop/models/PaymentMothod.dart';
import 'package:shop_app_clothes/features/shop/screens/checkout/widgets/select_option_payment.dart';

class TBillingPaymentSection extends StatefulWidget {
  final Function(int)
  onPaymentMethodSelected; // Callback to pass the selected ID back

  const TBillingPaymentSection({
    super.key,
    required this.onPaymentMethodSelected,
  });

  @override
  State<TBillingPaymentSection> createState() => _TBillingPaymentSectionState();
}

class _TBillingPaymentSectionState extends State<TBillingPaymentSection> {
  int _selectedPaymentMethodId = 1;
  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod(id: 1, name: 'Cash'),
    PaymentMethod(id: 2, name: 'MoMo'),
    PaymentMethod(id: 3, name: 'PayPal'),
  ]; // Add the actual methods you want to show

  @override
  Widget build(BuildContext context) {
    PaymentMethod selectedMethod = _paymentMethods.firstWhere(
      (method) => method.id == _selectedPaymentMethodId,
    );

    return Column(
      children: [
        TSectionHeading(
          title: "Payment Method",
          buttonTitle: "Change",
          onPressed: _selectPaymentMethod,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Icon(Icons.payment, size: 24, color: Colors.deepPurple),
            const SizedBox(width: 16),
            Text(
              selectedMethod.name, // Display the payment method name
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ],
    );
  }

  void _selectPaymentMethod() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectOptionPayment()),
    );
    if (result != null) {
      setState(() {
        _selectedPaymentMethodId =
            result; // Update the selected payment method ID
      });
      widget.onPaymentMethodSelected(result); // Pass selected ID back to parent
    }
  }
}
