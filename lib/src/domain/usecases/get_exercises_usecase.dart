import '../entities/exercises/exercise_model.dart';
import '../repositories/course_repository.dart';
import 'usecase.dart';

class GetExercisesUsecase
    implements UseCase<Future<List<Exercise>?>, GetExercisesParams> {
  final CourseRepository repository;

  GetExercisesUsecase({required this.repository});

  @override
  Future<List<Exercise>?> call(GetExercisesParams params) async {
    return await repository.getExercises(
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
