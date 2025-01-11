import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_clothes/features/shop/models/OrderItem.dart';

class OrderItemDetailsScreen extends StatelessWidget {
  final OrderItem orderItem;

  // Define your color and size mappings
  final Map<int, String> colorMapping = {
    1: 'White',
    2: 'Black',
    3: 'Green',
    4: 'Blue',
    5: 'Light Green',
    // Add other color mappings here
  };

  final Map<int, String> sizeMapping = {
    1: 'S',
    2: 'M',
    3: 'L',
    4: 'XL',
    5: 'XXL',
    // Add other size mappings here
  };

  OrderItemDetailsScreen({required this.orderItem, super.key});

  @override
  Widget build(BuildContext context) {
    // Get the color and size names based on their IDs
    String colorName = colorMapping[orderItem.colorId] ?? 'Unknown';
    String sizeName = sizeMapping[orderItem.sizeId] ?? 'Unknown';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Item Details',
          style: TextStyle(
            fontFamily: 'Poppins', // Using Poppins or Roboto for a modern look
            fontSize: 22,
            fontWeight:
                FontWeight.w600, // Slightly lighter to balance the weight
          ),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey[50], // Soft light gray background
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Card(
                elevation: 4,
                shadowColor: Colors.blueGrey.withOpacity(
                  0.15,
                ), // Subtle shadow for depth
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    20,
                  ), // Rounded corners for the card
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image at the top
                      Center(
                        child: Image.network(
                          'https://img.freepik.com/free-photo/young-handsome-man-coat-outside-street_1303-20446.jpg?ga=GA1.1.203008510.1736129615&semt=ais_hybrid',
                          height: 250, // Adjust size of the image
                          width: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 40),

                      // Product Name and Price in a Row
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
                                  orderItem.productName.toString(),
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
                                  'PricePrice',
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

                      // Color and Size stacked vertically
                      SizedBox(height: 20),
                      Divider(),
                      SizedBox(height: 20),

                      // Quantity
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
