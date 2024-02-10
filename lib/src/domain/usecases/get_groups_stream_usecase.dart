import '../entities/firestore/firestore_group_model.dart';
import '../repositories/discussion_repository.dart';
import 'usecase.dart';

class GetGroupsStreamUsecase
    implements UseCase<Stream<List<FirestoreGroupModel>>, void> {
  final DiscussionRepository repository;

  GetGroupsStreamUsecase({required this.repository});

  @override
  Stream<List<FirestoreGroupModel>> call(void params) {
    return repository.getGroupsStream();
  }
}
