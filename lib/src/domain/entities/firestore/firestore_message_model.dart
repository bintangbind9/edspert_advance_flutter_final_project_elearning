import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreMessageModel {
  final String email;
  final String message;
  final Timestamp time;

  FirestoreMessageModel({
    required this.email,
    required this.message,
    required this.time,
  });

  FirestoreMessageModel.fromJson(Map<String, Object?> json)
      : this(
          email: json['email']! as String,
          message: json['message']! as String,
          time: json['time']! as Timestamp,
        );

  Map<String, Object?> toJson() {
    return {
      'email': email,
      'message': message,
      'time': time,
    };
  }
}
