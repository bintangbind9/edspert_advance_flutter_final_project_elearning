import 'dart:typed_data';

import '../../common/constants/general_values.dart';
import '../entities/firestore/firestore_message_model.dart';
import '../repositories/discussion_repository.dart';
import 'usecase.dart';

class SendMessageWithFilesUsecase
    implements UseCase<Future<bool>, SendMessageWithFilesParams> {
  final DiscussionRepository repository;

  SendMessageWithFilesUsecase({required this.repository});

  @override
  Future<bool> call(SendMessageWithFilesParams params) async {
    return await repository.sendMessageWithFiles(
      groupId: params.groupId,
      message: params.message,
      files: params.files,
      storagePath: params.storagePath,
    );
  }
}

class SendMessageWithFilesParams {
  final String groupId;
  final FirestoreMessageModel message;
  final Map<String, Uint8List> files;
  final StoragePath storagePath;

  SendMessageWithFilesParams({
    required this.groupId,
    required this.message,
    required this.files,
    required this.storagePath,
  });
}
