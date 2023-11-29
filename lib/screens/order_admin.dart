import 'package:flutter/material.dart';
import 'package:new_shop/screens/order_details.dart';

class OrderDetailsPage extends StatelessWidget {
  final List<Order> orders = [
    Order(
      customerName: 'John Doe',
      address: '123 Main St, Cityville',
      items: [
        OrderItem(name: 'Product 1', quantity: 2, price: 25.0),
        OrderItem(name: 'Product 2', quantity: 1, price: 30.0),
      ],
      phoneNumber: '123-456-7890',
    ),
    Order(
      customerName: 'Jane Smith',
      address: '456 Oak St, Townsville',
      items: [
        OrderItem(name: 'Product 3', quantity: 3, price: 15.0),
        OrderItem(name: 'Product 4', quantity: 2, price: 20.0),
      ],
      phoneNumber: '987-654-3210',
    ),
    // Add more orders as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminOrderDetailPage(),
                  ),
                );
              },
              child: Center(
                child: Container(
                  width: 300, // Adjust the width of the box as needed
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.lightGreen, // Set the color of the box
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.grey.withOpacity(0.8), // Adjust the opacity
                        spreadRadius: 4, // Increase the spread radius
                        blurRadius: 10, // Increase the blur radius
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: OrderDetailsWidget(order: orders[index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Order {
  final String customerName;
  final String address;
  final List<OrderItem> items;
  final String phoneNumber;

  Order({
    required this.customerName,
    required this.address,
    required this.items,
    required this.phoneNumber,
  });
}

class OrderItem {
  final String name;
  final int quantity;
  final double price;

  OrderItem({
    required this.name,
    required this.quantity,
    required this.price,
  });
}

class OrderDetailsWidget extends StatelessWidget {
  final Order order;

  const OrderDetailsWidget({required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Customer Name: ${order.customerName}'),
        SizedBox(height: 8),
        Text('Address: ${order.address}'),
        SizedBox(height: 8),
        Text('Phone Number: ${order.phoneNumber}'),
        SizedBox(height: 16),
        Text('Order Items:'),
        Column(
          children: order.items.map((item) {
            return ListTile(
              title: Text('Item: ${item.name}'),
              subtitle: Text(
                  'Quantity: ${item.quantity}, Price: \$${item.price.toString()}'),
            );
          }).toList(),
        ),
      ],
    );
  }
}
