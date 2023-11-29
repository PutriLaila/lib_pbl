import 'package:flutter/material.dart';
import 'package:new_shop/screens/add_product.dart';

class Product {
  final String name;
  final String imageUrl;

  Product({required this.name, required this.imageUrl});
}

class AdminProduct extends StatefulWidget {
  @override
  _AdminProductState createState() => _AdminProductState();
}

class _AdminProductState extends State<AdminProduct> {
  List<Product> products = [
    Product(name: 'Product 1', imageUrl: 'assets/logo.png'),
    Product(name: 'Product 2', imageUrl: 'assets/logo.png'),
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProductPage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              width: 60, // Set the width of the container as needed
              height: 60, // Set the height of the container as needed
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(products[index].imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(products[index].name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Add functionality to edit the product
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // Add functionality to delete the product
                    setState(() {
                      products.removeAt(index);
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
