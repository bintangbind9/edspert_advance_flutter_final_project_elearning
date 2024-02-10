import '../entities/firestore/firestore_message_model.dart';
import '../repositories/discussion_repository.dart';
import 'usecase.dart';

class GetMessagesStreamUsecase
    implements UseCase<Stream<List<FirestoreMessageModel>>, String> {
  final DiscussionRepository repository;

  GetMessagesStreamUsecase({required this.repository});

  @override
  Stream<List<FirestoreMessageModel>> call(String groupId) {
    return repository.getMessagesStream(groupId: groupId);
  }
}
