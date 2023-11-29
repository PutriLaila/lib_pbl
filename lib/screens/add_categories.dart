import 'package:flutter/material.dart';
import 'package:new_shop/screens/categories_admin.dart';

class AddCategoryPage extends StatefulWidget {
  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController categoryDescriptionController =
      TextEditingController();

  String? imagePath; // Initialize imagePath with null

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the admin product page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AdminCategories()),
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
                  // For simplicity, we'll just set a placeholder image path
                  setState(() {
                    imagePath =
                        'https://via.placeholder.com/150'; // Replace with your image upload logic
                  });
                },
                child: Text('Upload Image'),
              ),
              SizedBox(height: 16),
              // Image preview (optional)
              imagePath != null
                  ? Image.network(imagePath!) // Display the uploaded image
                  : Container(),
              SizedBox(height: 16),
              // Other category details
              TextFormField(
                controller: categoryNameController,
                decoration: InputDecoration(labelText: 'Category Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the category name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: categoryDescriptionController,
                maxLines: 3,
                decoration: InputDecoration(labelText: 'Category Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the category description';
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
                    print('Category Name: ${categoryNameController.text}');
                    print(
                        'Category Description: ${categoryDescriptionController.text}');
                    print('Image Path: $imagePath');

                    // You can add further logic here to send data to the actual backend
                  }
                },
                child: Text('Add Category'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
