import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../common/constants/general_values.dart';
import '../../domain/entities/firestore/firestore_group_model.dart';
import '../../domain/entities/firestore/firestore_message_model.dart';
import '../../domain/entities/firestore/firestore_user_model.dart';
import 'storage_service.dart';

class FirestoreService {
  final StorageService storageService;

  // reference for our collections
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection('groups');

  FirestoreService({required this.storageService});

  // saving the user data
  Future<void> createOrUpdateUser({
    required String uid,
    required String email,
  }) async {
    return await userCollection.doc(uid).set({
      "email": email,
      "groups": [],
      "uid": uid,
    });
  }

  // get user
  Future<QuerySnapshot> getUser({
    required String uid,
    required String email,
  }) async {
    QuerySnapshot snapshot = await userCollection
        .where(
          "email",
          isEqualTo: email,
        )
        .get();
    return snapshot;
  }

  // get user by uid
  Future<DocumentSnapshot> getUserById({required String uid}) async {
    return await userCollection.doc(uid).get();
  }

  // get user stream
  Stream<DocumentSnapshot> getUserStream({required String uid}) {
    return userCollection.doc(uid).snapshots();
  }

  // get user group stream
  Stream<List<dynamic>> getUserGroupStream({required String uid}) {
    final userModelRef = userCollection.withConverter<FirestoreUserModel>(
      fromFirestore: (snapshot, _) =>
          FirestoreUserModel.fromJson(snapshot.data()!),
      toFirestore: (userModel, _) => userModel.toJson(),
    );
    return userModelRef
        .doc(uid)
        .snapshots()
        .map((DocumentSnapshot<FirestoreUserModel> doc) {
      return doc.data()!.groups;
    });
  }

  // creating a group
  Future<void> createGroup({
    required String uid,
    required String groupName,
  }) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": uid,
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
      "recentMessageTime": Timestamp
    });

    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion([uid]),
      "groupId": groupDocumentReference.id
    });

    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      "groups": FieldValue.arrayUnion([groupDocumentReference.id])
    });
  }

  // getting the chats
  Stream<QuerySnapshot<Map<String, dynamic>>> getChatsStream(
      {required String groupId}) {
    return groupCollection
        .doc(groupId)
        .collection('messages')
        .orderBy('time', descending: true)
        .snapshots();
  }

  // getting the messages
  Stream<List<FirestoreMessageModel>> getMessagesStream({
    required String groupId,
  }) {
    final messageModelRef = groupCollection
        .doc(groupId)
        .collection('messages')
        .withConverter<FirestoreMessageModel>(
          fromFirestore: (snapshot, _) =>
              FirestoreMessageModel.fromJson(snapshot.data()!),
          toFirestore: (messageModel, _) => messageModel.toJson(),
        );
    return messageModelRef.orderBy('time', descending: true).snapshots().map(
      (QuerySnapshot<FirestoreMessageModel> query) {
        return query.docs.map((e) => e.data()).toList();
      },
    );
  }

  // getting group admin
  Future<String> getGroupAdmin({required String groupId}) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'].toString();
  }

  // getting group members
  Stream<DocumentSnapshot> getGroupStream({required String groupId}) {
    return groupCollection.doc(groupId).snapshots();
  }

  // getting all groups
  Stream<List<FirestoreGroupModel>> getGroupsStream() {
    final groupModelRef = groupCollection.withConverter<FirestoreGroupModel>(
      fromFirestore: (snapshot, _) =>
          FirestoreGroupModel.fromJson(snapshot.data()!),
      toFirestore: (groupModel, _) => groupModel.toJson(),
    );
    return groupModelRef
        .snapshots()
        .map((QuerySnapshot<FirestoreGroupModel> query) {
      List<FirestoreGroupModel> groups = <FirestoreGroupModel>[];
      for (DocumentSnapshot<FirestoreGroupModel> group in query.docs) {
        groups.add(group.data()!);
      }
      return groups;
    });
  }

  // search group by name
  Future<QuerySnapshot> searchGroupByName({required String groupName}) async {
    return await groupCollection.where("groupName", isEqualTo: groupName).get();
  }

  // check is user joined the group
  Future<bool> isUserJoined({
    required String uid,
    required String groupId,
  }) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<String> groups = await documentSnapshot['groups'];
    if (groups.contains(groupId)) {
      return true;
    } else {
      return false;
    }
  }

  // toggling the group join or exit
  Future<void> toggleGroupJoin({
    required String uid,
    required String groupId,
  }) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);

    DocumentSnapshot userDocumentSnapshot = await userDocumentReference.get();
    List<String> groups = await userDocumentSnapshot['groups'];

    // if user has our groups -> then remove or also in other part re join
    String group = groupId;
    String member = uid;
    if (groups.contains(group)) {
      await userDocumentReference.update({
        "groups": FieldValue.arrayRemove([group])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayRemove([member])
      });
    } else {
      await userDocumentReference.update({
        "groups": FieldValue.arrayUnion([group])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayUnion([member])
      });
    }
  }

  // send message
  Future<bool> sendMessage({
    required String groupId,
    required FirestoreMessageModel message,
  }) async {
    try {
      Map<String, dynamic> chatMessageData = {
        "message": message.message,
        "email": message.email,
        "time": message.time
      };
      await groupCollection
          .doc(groupId)
          .collection("messages")
          .add(chatMessageData);
      await groupCollection.doc(groupId).update({
        "recentMessage": chatMessageData['message'],
        "recentMessageSender": chatMessageData['email'],
        "recentMessageTime": chatMessageData['time'],
      });

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  // send message with files
  Future<bool> sendMessageWithFiles({
    required String groupId,
    required FirestoreMessageModel message,
    required Map<String, Uint8List> files,
    required StoragePath storagePath,
  }) async {
    try {
      List<String> filesUrl = [];

      for (final file in files.entries) {
        UploadFileResult uploadFileResult = await storageService.uploadFile(
          fileName: file.key,
          fileByte: file.value,
          storagePath: storagePath,
        );

        if (uploadFileResult.isSuccess) {
          filesUrl.add(uploadFileResult.downloadUrl!);
        } else {
          log('Send message with files error! Error when uploading files!');
          return false;
        }
      }

      Map<String, dynamic> chatMessageData = {
        "message": message.message,
        "email": message.email,
        "time": message.time,
        "files": FieldValue.arrayUnion(filesUrl),
      };
      await groupCollection
          .doc(groupId)
          .collection("messages")
          .add(chatMessageData);
      await groupCollection.doc(groupId).update({
        "recentMessage": chatMessageData['message'],
        "recentMessageSender": chatMessageData['email'],
        "recentMessageTime": chatMessageData['time'],
      });

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
