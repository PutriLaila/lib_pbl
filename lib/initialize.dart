// admin_initializer.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void initializeAdminAccount() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    await _auth.createUserWithEmailAndPassword(
      email: 'admin@gmail.com',
      password: 'admin123',
    );

    final adminUser = await _auth.signInWithEmailAndPassword(
      email: 'admin@gmail.com',
      password: 'admin123',
    );

    await _firestore.collection('users').doc(adminUser.user!.uid).set({
      'email': adminUser.user!.email,
      'role': 'admin',
    });
  } catch (e) {
    print('Error initializing admin account: $e');
  }
}
