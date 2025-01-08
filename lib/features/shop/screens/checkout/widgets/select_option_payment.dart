import 'package:flutter/material.dart';
import 'package:shop_app_clothes/features/shop/models/PaymentMothod.dart';
import 'package:shop_app_clothes/features/shop/screens/service/PaymentMethodService%20.dart';

class SelectOptionPayment extends StatefulWidget {
  const SelectOptionPayment({super.key});

  @override
  State<SelectOptionPayment> createState() => _SelectOptionPaymentState();
}

class _SelectOptionPaymentState extends State<SelectOptionPayment> {
  final PaymentMethodService _service = PaymentMethodService();
  List<PaymentMethod> _paymentMethods = [];
  String? _selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final methods = await _service.fetchPaymentMethods();
      setState(() {
        _paymentMethods = methods;
        _selectedPaymentMethod = methods.isNotEmpty ? methods[0].name : null;
      });
    } catch (error) {
      // Handle errors
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Lỗi tải dữ liệu: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn Phương Thức Thanh Toán'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body:
          _paymentMethods.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Phương thức thanh toán',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ..._paymentMethods.map(
                      (method) => RadioListTile<String>(
                        title: Text(method.name),
                        // subtitle: Text(method.description ?? 'Không có mô tả'),
                        value: method.name,
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod = value!;
                          });
                        },
                        activeColor: Colors.deepPurple,
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_selectedPaymentMethod != null) {
                            // Trả về phương thức thanh toán đã chọn
                            Navigator.pop(context, _selectedPaymentMethod);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Vui lòng chọn phương thức thanh toán',
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        child: const Text('Xác nhận'),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
