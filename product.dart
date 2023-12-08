import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_shop/screens/add_product.dart';

class AdminProduct extends StatefulWidget {
  @override
  _AdminProductState createState() => _AdminProductState();
}

class _AdminProductState extends State<AdminProduct> {
  late Stream<QuerySnapshot> _productsStream;

  @override
  void initState() {
    super.initState();
    _productsStream =
        FirebaseFirestore.instance.collection('products').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: _productsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          var products = snapshot.data?.docs;

          return ListView.builder(
            itemCount: products?.length ?? 0,
            itemBuilder: (context, index) {
              var product = products?[index].data() as Map<String, dynamic>;

              if (product == null) {
                return Container(); // Skip the ListTile if the product data is null
              }

              return ListTile(
                leading: Container(
                  width: 60, // Set the width of the container as needed
                  height: 60, // Set the height of the container as needed
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(product['imageUrl']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(product['name'] ?? ''),
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
                      onPressed: () async {
                        // Add functionality to delete the product
                        await FirebaseFirestore.instance
                            .collection('products')
                            .doc(products?[index].id)
                            .delete();
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
