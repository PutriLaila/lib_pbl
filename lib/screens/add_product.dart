import 'package:flutter/material.dart';
import 'package:new_shop/screens/product_admin.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productDescriptionController =
      TextEditingController();

  get imagePath => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        // Add a leading back button
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the admin product page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AdminProduct()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image upload section
              ElevatedButton(
                onPressed: () {
                  // Implement image upload logic here
                },
                child: Text('Upload Image'),
              ),
              SizedBox(height: 16),
              // Image preview (optional)
              imagePath != null
                  ? Image.network(imagePath) // Display the uploaded image
                  : Container(),
              SizedBox(height: 16),
              TextFormField(
                controller: productNameController,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the product name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: productPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Product Price'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the product price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: productDescriptionController,
                maxLines: 3,
                decoration: InputDecoration(labelText: 'Product Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the product description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Form is valid, you can simulate the backend logic here
                    // For example, print the values to the console
                    print('Product Name: ${productNameController.text}');
                    print('Product Price: ${productPriceController.text}');
                    print(
                        'Product Description: ${productDescriptionController.text}');

                    // You can add further logic here to send data to the actual backend
                  }
                },
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
