import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(String uid, String email, String role) async {
    await _firestore.collection('users').doc(uid).set({
      'email': email,
      'role': role,
    });
  }
}
