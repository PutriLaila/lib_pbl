import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  final ImagePicker _imagePicker = ImagePicker();
  String? imagePath;

  Future<void> _pickImage() async {
    try {
      final pickedFile =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          imagePath = pickedFile.path;
        });
      }
    } catch (error) {
      print('Error picking image: $error');
    }
  }

  Future<String> _uploadImage() async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference storageReference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('images/$fileName');

      await storageReference.putFile(File(imagePath!));
      String downloadURL = await storageReference.getDownloadURL();
      return downloadURL;
    } catch (error) {
      print('Error uploading image: $error');
      return '';
    }
  }

  Future<void> _uploadCategoryData() async {
    try {
      String downloadURL = await _uploadImage();
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      await firestore.collection('categories').add({
        'name': categoryNameController.text,
        'description': categoryDescriptionController.text,
        'imagePath': downloadURL,
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminCategories()),
      );
    } catch (error) {
      print('Error uploading category data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
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
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Choose Image'),
              ),
              SizedBox(height: 16),
              imagePath != null
                  ? Image.file(
                      File(imagePath!),
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _uploadCategoryData();
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
