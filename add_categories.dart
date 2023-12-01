import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_shop/screens/categories_admin.dart';
import 'package:new_shop/model/add_category_model.dart';
import 'package:new_shop/firebase_service.dart';
import 'package:image_picker/image_picker.dart';

class AddCategoryPage extends StatefulWidget {
  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController categoryDescriptionController =
      TextEditingController();

  String? imagePath;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Choose Image'),
              ),
              SizedBox(height: 16),
              imagePath != null
                  ? Image.file(
                      File(imagePath!),
                      height: 150,
                    )
                  : Container(),
              SizedBox(height: 16),
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Category newCategory = Category(
                      name: categoryNameController.text,
                      description: categoryDescriptionController.text,
                      imageUrl: imagePath ?? '',
                    );

                    FirebaseService firebaseService = FirebaseService();
                    await firebaseService.addCategory(newCategory);
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
