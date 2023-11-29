// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:new_shop/screens/add_categories.dart';
import 'package:new_shop/screens/add_product.dart';
import 'package:new_shop/screens/categories_admin.dart';
import 'package:new_shop/screens/admin_product.dart';
import 'package:new_shop/screens/customer_acount.dart';
import 'package:new_shop/screens/login_screens.dart';
import 'package:new_shop/screens/order_admin.dart';
import 'package:new_shop/screens/product_admin.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Placeholder data
  int totalSales = 10000;
  int totalProducts = 150;
  int totalCategories = 10;
  int totalCustomers = 500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightGreen,
              ),
              child: Text(
                'E-commerce Admin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28, // Adjust the font size here
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 18, // Adjust the font size here
                ),
              ),
              onTap: () {
                // Handle dashboard tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text(
                'Products',
                style: TextStyle(
                  fontSize: 18, // Adjust the font size here
                ),
              ),
              onTap: () {
                // Handle products tap
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminProduct()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 18, // Adjust the font size here
                ),
              ),
              onTap: () {
                // Handle categories tap
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AdminCategories()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text(
                'Orders',
                style: TextStyle(
                  fontSize: 18, // Adjust the font size here
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderDetailsPage()),
                );
                // Handle orders tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text(
                'Users',
                style: TextStyle(
                  fontSize: 18, // Adjust the font size here
                ),
              ),
              onTap: () {
                // Handle users
                // Handle products tap
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomerAccountPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.all(16),
        children: [
          _buildDashboardCard(
            'Total Sales',
            totalSales,
            Icons.attach_money,
            () {
              // Handle Total Sales tap
              print('Total Sales Tapped');
            },
          ),
          _buildDashboardCard(
            'Total Products',
            totalProducts,
            Icons.shopping_basket,
            () {
              _navigateToAdminProductPage;
            },
          ),
          _buildDashboardCard(
            'Total Categories',
            totalCategories,
            Icons.category,
            () {
              // Handle Total Categories tap
              print('Total Categories Tapped');
            },
          ),
          _buildDashboardCard(
            'Total Customers',
            totalCustomers,
            Icons.people,
            () {
              // Handle Total Customers tap
              print('Total Customers Tapped');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(
    String title,
    int value,
    IconData iconData,
    VoidCallback onPressed,
  ) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Icon(
                iconData,
                size: 40,
                color: Colors.blue,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                value.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _navigateToAdminProductPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AdminProduct()),
  );
}
