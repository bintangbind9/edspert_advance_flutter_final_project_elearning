import 'dart:typed_data';

import '../../common/constants/general_values.dart';
import '../entities/firestore/firestore_group_model.dart';
import '../entities/firestore/firestore_message_model.dart';

abstract class DiscussionRepository {
  Stream<List<FirestoreGroupModel>> getGroupsStream();
  Stream<List<FirestoreMessageModel>> getMessagesStream({
    required String groupId,
  });
  Future<bool> sendMessage({
    required String groupId,
    required FirestoreMessageModel message,
  });
  Future<bool> sendMessageWithFiles({
    required String groupId,
    required FirestoreMessageModel message,
    required Map<String, Uint8List> files,
    required StoragePath storagePath,
  });
}
