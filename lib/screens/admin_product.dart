import 'package:flutter/material.dart';

class AdminProductPage extends StatefulWidget {
  @override
  _AdminProductPageState createState() => _AdminProductPageState();
}

class _AdminProductPageState extends State<AdminProductPage> {
  // Dummy product data, replace with actual data from your backend
  final List<Product> products = [
    Product('Product 1', 'Description 1'),
    Product('Product 2', 'Description 2'),
    Product('Product 3', 'Description 3'),
    // Add more product data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Product Page'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name),
            subtitle: Text(products[index].description),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _showDeleteDialog(index);
              },
            ),
          );
        },
      ),
    );
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Product'),
          content:
              Text('Are you sure you want to delete ${products[index].name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteProduct(index);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }
}

class Product {
  final String name;
  final String description;

  Product(this.name, this.description);
}
