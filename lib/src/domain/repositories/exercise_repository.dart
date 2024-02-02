import '../entities/exercise_model.dart';

abstract class ExerciseRepository {
  Future<List<Exercise>?> getExercisesByCourseIdAndEmail({
    required String courseId,
    required String email,
  });
}
