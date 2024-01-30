import 'package:edspert_advance_flutter_final_project_elearning/data/model/exercise_model.dart';
import 'package:edspert_advance_flutter_final_project_elearning/data/model/response_model.dart';

abstract class ExerciseRepository {
  Future<ResponseModel<List<Exercise>>> getExercisesByCourseIdAndEmail({
    required String courseId,
    required String email,
  });
}
