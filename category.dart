import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_shop/screens/add_categories.dart';

class AdminCategories extends StatefulWidget {
  const AdminCategories({Key? key}) : super(key: key);

  @override
  _AdminCategoriesState createState() => _AdminCategoriesState();
}

class _AdminCategoriesState extends State<AdminCategories> {
  late Stream<QuerySnapshot> _categoriesStream;

  @override
  void initState() {
    super.initState();
    _categoriesStream =
        FirebaseFirestore.instance.collection('categories').snapshots();
  }

  void _showEditSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Category successfully edited'),
      ),
    );
  }

  void _showDeleteSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Category successfully deleted'),
      ),
    );
  }

  Future<void> _deleteCategory(String categoryId) async {
    try {
      // Delete category from Firestore
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .delete();
    } catch (e) {
      print('Error deleting category: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddCategoryPage()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _categoriesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          var categories = snapshot.data?.docs;

          return ListView.builder(
            itemCount: categories?.length ?? 0,
            itemBuilder: (context, index) {
              var category = categories?[index].data() as Map<String, dynamic>;

              if (category == null) {
                return Container(); // Skip the ListTile if the category data is null
              }

              var imageUrl = category['imagePath'] as String?;
              var categoryId = categories?[index].id;

              return ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    image: imageUrl != null
                        ? DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          )
                        : null, // Handle null image URL
                  ),
                ),
                title: Text(category['name'] ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        print('Edit Category pressed for ${category['name']}');
                        _showEditSnackbar();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        print(
                            'Delete Category pressed for ${category['name']}');
                        await _deleteCategory(categoryId!);
                        _showDeleteSnackbar();
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
