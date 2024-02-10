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
}
