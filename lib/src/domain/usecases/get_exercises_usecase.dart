import '../entities/exercise_model.dart';
import '../repositories/exercise_repository.dart';
import 'usecase.dart';

class GetExercisesUsecase
    implements UseCase<List<Exercise>?, GetExercisesParams> {
  final ExerciseRepository repository;

  GetExercisesUsecase({required this.repository});

  @override
  Future<List<Exercise>?> call(GetExercisesParams params) async {
    return await repository.getExercisesByCourseIdAndEmail(
      courseId: params.courseId,
      email: params.email,
    );
  }
}

class GetExercisesParams {
  final String courseId;
  final String email;

  GetExercisesParams({
    required this.courseId,
    required this.email,
  });
}
