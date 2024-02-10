import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreMessageModel {
  final String email;
  final String message;
  final Timestamp time;
  final List<String>? files;

  FirestoreMessageModel({
    required this.email,
    required this.message,
    required this.time,
    this.files,
  });

  FirestoreMessageModel.fromJson(Map<String, dynamic> json)
      : this(
          email: json['email']! as String,
          message: json['message']! as String,
          time: json['time']! as Timestamp,
          files: json['files'] == null
              ? []
              : List<String>.from(json["files"]!.map((x) => x)),
        );

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'message': message,
      'time': time,
      'files': files == null ? [] : List<dynamic>.from(files!.map((x) => x)),
    };
  }
}
