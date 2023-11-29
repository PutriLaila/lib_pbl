import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Bina Kreasi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Kami adalah toko furnitur yang menyediakan berbagai macam desain furnitur dengan kualitas terbaik dan harga yang terjangkau.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Container(
              height: 200,
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(37.7749, -122.4194),
                  zoom: 15.0,
                ),
                markers: {
                  const Marker(
                    markerId: MarkerId('storeLocation'),
                    position: LatLng(37.7749, -122.4194),
                    infoWindow: InfoWindow(title: 'Store Location'),
                  ),
                },
              ),
            ),
            const SizedBox(height: 20),
            _buildContactCard(
              Icon(Icons.phone),
              'Phone Number',
              '+1 123-456-7890',
            ),
            const SizedBox(height: 10),
            _buildContactCard(
              Icon(Icons.mail),
              'Email',
              'info@store.com',
            ),
            const SizedBox(height: 10),
            _buildContactCard(
              Icon(Icons.location_on),
              'Address',
              '123 Main St, Cityville',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(Icon icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: ListTile(
          leading: icon,
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
