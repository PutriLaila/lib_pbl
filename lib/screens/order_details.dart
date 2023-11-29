import 'package:flutter/material.dart';

class AdminOrderDetailPage extends StatefulWidget {
  @override
  _AdminOrderDetailPageState createState() => _AdminOrderDetailPageState();
}

class _AdminOrderDetailPageState extends State<AdminOrderDetailPage> {
  // Sample order data
  final Order order = Order(
    orderId: '12345',
    customerName: 'John Doe',
    address: '123 Main St, Cityville',
    items: [
      OrderItem(name: 'Product 1', quantity: 2, price: 25.0),
      OrderItem(name: 'Product 2', quantity: 1, price: 30.0),
    ],
    phoneNumber: '123-456-7890',
    orderStatus: OrderStatus.OrderBeingMade,
  );

  OrderStatus _selectedOrderStatus = OrderStatus.OrderBeingMade;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.lightGreen, // Set the color of the box
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order ID: ${order.orderId}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Customer Name: ${order.customerName}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Address: ${order.address}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Phone Number: ${order.phoneNumber}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Order Items:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: order.items.map((item) {
                      return ListTile(
                        title: Text('Item: ${item.name}'),
                        subtitle: Text(
                          'Quantity: ${item.quantity}, Price: \$${item.price.toString()}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Order Status:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Column(
              children: OrderStatus.values.map((status) {
                return RadioListTile<OrderStatus>(
                  title: Text(
                    status.toString().split('.').last,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  value: status,
                  groupValue: _selectedOrderStatus,
                  onChanged: (value) {
                    setState(() {
                      _selectedOrderStatus = value!;
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Save logic here
                  print('Save button pressed');
                },
                child: Text(
                  'Save',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum OrderStatus {
  OrderBeingMade,
  PackingOrder,
  OrderBeingDelivered,
  OrderReachedCustomer,
}

class Order {
  final String orderId;
  final String customerName;
  final String address;
  final List<OrderItem> items;
  final String phoneNumber;
  OrderStatus orderStatus;

  Order({
    required this.orderId,
    required this.customerName,
    required this.address,
    required this.items,
    required this.phoneNumber,
    this.orderStatus = OrderStatus.OrderBeingMade,
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
