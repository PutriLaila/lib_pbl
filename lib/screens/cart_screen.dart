import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Dummy data for demonstration
  List<Map<String, dynamic>> cartItems = [
    {"name": "Product 1", "quantity": 2, "price": 20.0},
    {"name": "Product 2", "quantity": 1, "price": 15.0},
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    double totalPrice = cartItems.fold(
        0, (sum, item) => sum + item["quantity"] * item["price"]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return CartItemCard(
                  name: cartItems[index]["name"],
                  quantity: cartItems[index]["quantity"],
                  price: cartItems[index]["price"],
                  onAdd: () {
                    // Implement add functionality
                    setState(() {
                      cartItems[index]["quantity"]++;
                    });
                  },
                  onDelete: () {
                    // Implement delete functionality
                    setState(() {
                      if (cartItems[index]["quantity"] > 1) {
                        cartItems[index]["quantity"]--;
                      } else {
                        cartItems.removeAt(index);
                      }
                    });
                  },
                );
              },
            ),
          ),
          TotalPriceWidget(totalPrice: totalPrice),
          CheckoutButton(),
        ],
      ),
    );
  }
}

class CartItemCard extends StatelessWidget {
  final String name;
  final int quantity;
  final double price;
  final VoidCallback onAdd;
  final VoidCallback onDelete;

  CartItemCard({
    required this.name,
    required this.quantity,
    required this.price,
    required this.onAdd,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: ListTile(
        leading: CircleAvatar(
          // Replace with actual product image
          child: Icon(Icons.shopping_cart),
        ),
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Quantity: $quantity'),
            Text('Price: \$${(quantity * price).toStringAsFixed(2)}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: onAdd,
            ),
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

class TotalPriceWidget extends StatelessWidget {
  final double totalPrice;

  TotalPriceWidget({required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Price:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            '\$${totalPrice.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class CheckoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          // Implement checkout functionality
          // This could navigate to a checkout page or perform other actions
        },
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold), // Set the font size here
        ),
        child: Text('Checkout'),
      ),
    );
  }
}
