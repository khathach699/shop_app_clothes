import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_clothes/features/shop/models/OrderItem.dart'; // Make sure OrderItem is imported correctly.

class OrderItemDetailsScreen extends StatelessWidget {
  final List<OrderItem> orderItems; // Chuyển từ OrderItem sang List<OrderItem>

  OrderItemDetailsScreen({required this.orderItems, super.key});

  // Define your color and size mappings
  final Map<int, String> colorMapping = {
    1: 'White',
    2: 'Black',
    3: 'Green',
    4: 'Blue',
    5: 'Light Green',
  };

  final Map<int, String> sizeMapping = {
    1: 'S',
    2: 'M',
    3: 'L',
    4: 'XL',
    5: 'XXL',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Item Details',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey[50],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: orderItems.length, // Đếm số lượng sản phẩm
            itemBuilder: (context, index) {
              OrderItem orderItem = orderItems[index];

              // Get the color and size names based on their IDs
              String colorName = colorMapping[orderItem.colorId] ?? 'Unknown';
              String sizeName = sizeMapping[orderItem.sizeId] ?? 'Unknown';

              return Card(
                elevation: 4,
                shadowColor: Colors.blueGrey.withOpacity(0.15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image
                      // Center(
                      //   child: Image.network(
                      //     orderItem.imageUrl ?? 'https://default-image-url.com',
                      //     height: 250,
                      //     width: 250,
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                      SizedBox(height: 40),

                      // Product Name and Price
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Product Name',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  orderItem.productName ?? 'Unknown',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Price',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '\$${orderItem.priceAtOrder}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Divider(),
                      SizedBox(height: 20),

                      // Color and Size
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Color',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.palette,
                                      color: Colors.blueAccent,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      colorName,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Size',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Iconsax.size,
                                      color: Colors.blueAccent,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      sizeName,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Quantity
                      SizedBox(height: 20),
                      Divider(),
                      SizedBox(height: 20),

                      Text(
                        'Quantity',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${orderItem.quantity}',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
