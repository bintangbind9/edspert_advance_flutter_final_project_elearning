import '../entities/course_model.dart';
import '../entities/exercises/exercise_model.dart';
import '../entities/exercises/exercise_result.dart';
import '../entities/exercises/submit_exercise_answers_req.dart';
import '../entities/question_model/question_model.dart';
import '../entities/response_model.dart';

abstract class CourseRepository {
  Future<List<Course>?> getCourses({
    required String majorName,
    required String email,
  });

  Future<List<Exercise>?> getExercises({
    required String courseId,
    required String email,
  });

  Future<ResponseModel<List<Question>>?> getQuestions({
    required String exerciseId,
    required String email,
  });

  Future<ResponseModel<void>?> submitExerciseAnswers({
    required SubmitExerciseAnswersReq req,
  });

  Future<ResponseModel<ExerciseResult?>?> getExerciseResult({
    required String exerciseId,
    required String email,
  });
}
