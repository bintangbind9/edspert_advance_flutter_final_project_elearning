import '../entities/firestore/firestore_message_model.dart';
import '../repositories/discussion_repository.dart';
import 'usecase.dart';

class SendMessageUsecase implements UseCase<Future<void>, SendMessageParams> {
  final DiscussionRepository repository;

  SendMessageUsecase({required this.repository});

  @override
  Future<bool> call(SendMessageParams params) async {
    return await repository.sendMessage(
      groupId: params.groupId,
      message: params.message,
    );
  }
}

class SendMessageParams {
  final String groupId;
  final FirestoreMessageModel message;

  SendMessageParams({
    required this.groupId,
    required this.message,
  });
}
