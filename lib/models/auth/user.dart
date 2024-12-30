import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? email;
  final String? name;
  final String? password;
  final String? department;
  final String? staffId;
  final String? studentId;
  final String? userType;
  final String? level;
  final Timestamp? createdAt;

  UserModel({
     this.email,
    this.name,
     this.department,
     this.staffId,
     this.createdAt,
    this.userType,
    this.password,
    this.studentId,
    this.level
  });

  // Factory method to create a UserModel from a Firestore document snapshot
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return UserModel(
      email: data['email'] ?? '',
      studentId: data['studentId'] ?? '',
      department: data['department'] ?? '',
      staffId: data['staff_id'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      userType: data['user_type'] ?? '',
      password: data['password'] ?? '',
      level: data['level'] ?? '',
      name: data['name'] ?? '',
    );
  }

  // Method to convert UserModel to a Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'department': department,
      'staff_id': staffId,
      'createdAt': FieldValue.serverTimestamp(),
      'user_type': userType,
      'password': password,
      'studentId': studentId,
      'level': level,
      'name': name,

    };
  }
}
