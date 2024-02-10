import '../entities/exercises/submit_exercise_answers_req.dart';
import '../entities/response_model.dart';
import '../repositories/course_repository.dart';
import 'usecase.dart';

class SubmitExerciseAnswersUsecase
    implements UseCase<Future<ResponseModel<void>?>, SubmitExerciseAnswersReq> {
  final CourseRepository repository;

  SubmitExerciseAnswersUsecase({required this.repository});

  @override
  Future<ResponseModel<void>?> call(SubmitExerciseAnswersReq params) async {
    return await repository.submitExerciseAnswers(req: params);
  }
}
