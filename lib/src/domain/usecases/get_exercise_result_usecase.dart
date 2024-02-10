import '../entities/exercises/exercise_result.dart';
import '../entities/response_model.dart';
import '../repositories/course_repository.dart';
import 'usecase.dart';

class GetExerciseResultUsecase
    implements
        UseCase<Future<ResponseModel<ExerciseResult?>?>,
            GetExerciseResultParams> {
  final CourseRepository repository;

  GetExerciseResultUsecase({required this.repository});

  @override
  Future<ResponseModel<ExerciseResult?>?> call(
      GetExerciseResultParams params) async {
    return await repository.getExerciseResult(
      exerciseId: params.exerciseId,
      email: params.email,
    );
  }
}

class GetExerciseResultParams {
  final String exerciseId;
  final String email;

  GetExerciseResultParams({
    required this.exerciseId,
    required this.email,
  });
}
