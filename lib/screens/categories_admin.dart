import 'package:flutter/material.dart';
import 'package:new_shop/screens/add_categories.dart';

class Categories {
  final String name;
  final String imageUrl;

  Categories({required this.name, required this.imageUrl});
}

class AdminCategories extends StatefulWidget {
  const AdminCategories({super.key});

  @override
  State<AdminCategories> createState() => _AdminCategoriesState();
}

class _AdminCategoriesState extends State<AdminCategories> {
  List<Categories> categories = [
    Categories(name: 'Categories 1', imageUrl: 'assets/logo.png'),
    Categories(name: 'Categories 2', imageUrl: 'assets/logo.png'),
    // Add more products as needed
  ];
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
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              width: 60, // Set the width of the container as needed
              height: 60, // Set the height of the container as needed
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(categories[index].imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(categories[index].name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Add functionality to edit the product
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Add functionality to delete the product
                    setState(() {
                      categories.removeAt(index);
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
