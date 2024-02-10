import '../../domain/entities/firestore/firestore_group_model.dart';
import '../../domain/entities/firestore/firestore_message_model.dart';
import '../../domain/repositories/discussion_repository.dart';
import '../firebase/firestore_service.dart';

class DiscussionRepositoryImpl implements DiscussionRepository {
  final FirestoreService firestoreService;

  DiscussionRepositoryImpl({required this.firestoreService});

  @override
  Stream<List<FirestoreGroupModel>> getGroupsStream() {
    return firestoreService.getGroupsStream();
  }

  @override
  Stream<List<FirestoreMessageModel>> getMessagesStream({
    required String groupId,
  }) {
    return firestoreService.getMessagesStream(groupId: groupId);
  }

  @override
  Future<bool> sendMessage({
    required String groupId,
    required FirestoreMessageModel message,
  }) async {
    return await firestoreService.sendMessage(
      groupId: groupId,
      message: message,
    );
  }
}
