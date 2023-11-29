import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String uid;
  final String email;
  final String role;

  MyUser({required this.uid, required this.email, required this.role});

  factory MyUser.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return MyUser(
      uid: doc.id,
      email: data['email'] ?? '',
      role: data['role'] ?? 'customer',
    );
  }
}
