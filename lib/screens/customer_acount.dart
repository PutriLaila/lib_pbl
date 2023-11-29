import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomerAccountPage extends StatefulWidget {
  @override
  _CustomerAccountPageState createState() => _CustomerAccountPageState();
}

class _CustomerAccountPageState extends State<CustomerAccountPage> {
  late List<Customer> customers = []; // Initialize with an empty list

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      List<Customer> users = await _fetchUsersFromFirebase();
      setState(() {
        customers = users;
      });
    } catch (e) {
      print("Error fetching user data: $e");
      // Handle error (display a snackbar, show an error message, etc.)
    }
  }

  Future<List<Customer>> _fetchUsersFromFirebase() async {
    List<Customer> users = [];

    try {
      // Fetch user data from Firebase Authentication
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        List<UserInfo> providerData = currentUser.providerData;

        for (UserInfo userInfo in providerData) {
          // Fetch additional user details as needed
          // Example: Fetch the user's display name and email
          String displayName = userInfo.displayName ?? 'Unknown';
          String email = userInfo.email ?? 'Unknown';

          // Create a Customer object
          users.add(Customer(currentUser.uid, displayName, email));
        }
      }
    } catch (e) {
      print("Error fetching users from Firebase: $e");
      // Handle error (display a snackbar, show an error message, etc.)
    }

    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Accounts'),
        actions: [
          _buildProfileIcon(context),
        ],
      ),
      body: customers != null
          ? ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(customers[index].name),
                  subtitle: Text(customers[index].email),
                  onTap: () {
                    _navigateToProfile(context, customers[index]);
                  },
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _buildProfileIcon(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundImage:
          AssetImage('assets/logo.png'), // Replace with the actual image path
    );
  }

  void _navigateToProfile(BuildContext context, Customer customer) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(customer),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final Customer customer;

  ProfilePage(this.customer);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/logo.png'),
            ),
            SizedBox(height: 20),
            Text(
              customer.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              customer.email,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Customer {
  final String uid;
  final String name;
  final String email;

  Customer(this.uid, this.name, this.email);
}
