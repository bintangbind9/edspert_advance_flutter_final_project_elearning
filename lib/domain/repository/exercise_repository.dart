import 'package:edspert_advance_flutter_final_project_elearning/data/model/exercise_model.dart';

abstract class ExerciseRepository {
  Future<ExerciseResponse> getExercisesByCourseIdAndEmail({
    required String courseId,
    required String email,
  });
}
