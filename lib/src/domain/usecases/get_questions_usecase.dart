import '../entities/question_model/question_model.dart';
import '../entities/response_model.dart';
import '../repositories/course_repository.dart';
import 'usecase.dart';

class GetQuestionsUsecase
    implements
        UseCase<Future<ResponseModel<List<Question>>?>, GetQuestionsParams> {
  final CourseRepository repository;

  GetQuestionsUsecase({
    required this.repository,
  });

  @override
  Future<ResponseModel<List<Question>>?> call(GetQuestionsParams params) async {
    return await repository.getQuestions(
      exerciseId: params.exerciseId,
      email: params.email,
    );
  }
}

class GetQuestionsParams {
  final String exerciseId;
  final String email;

  GetQuestionsParams({
    required this.exerciseId,
    required this.email,
  });
}
