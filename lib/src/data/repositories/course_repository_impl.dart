import '../../domain/entities/course_model.dart';
import '../../domain/entities/exercises/exercise_model.dart';
import '../../domain/entities/exercises/exercise_result.dart';
import '../../domain/entities/exercises/submit_exercise_answers_req.dart';
import '../../domain/entities/question_model/question_model.dart';
import '../../domain/entities/response_model.dart';
import '../../domain/repositories/course_repository.dart';
import '../network/api_elearning.dart';

class CourseRepositoryImpl implements CourseRepository {
  final ApiElearning apiElearning;

  CourseRepositoryImpl({
    required this.apiElearning,
  });

  @override
  Future<List<Course>?> getCourses({
    required String majorName,
    required String email,
  }) async {
    return await apiElearning.getCourses(majorName: majorName, email: email);
  }

  @override
  Future<List<Exercise>?> getExercises({
    required String courseId,
    required String email,
  }) async {
    return await apiElearning.getExercises(
      courseId: courseId,
      email: email,
    );
  }

  @override
  Future<ResponseModel<List<Question>>?> getQuestions({
    required String exerciseId,
    required String email,
  }) async {
    return await apiElearning.getQuestions(
      exerciseId: exerciseId,
      email: email,
    );
  }

  @override
  Future<ResponseModel<void>?> submitExerciseAnswers({
    required SubmitExerciseAnswersReq req,
  }) async {
    return await apiElearning.submitExerciseAnswers(req: req);
  }

  @override
  Future<ResponseModel<ExerciseResult?>?> getExerciseResult({
    required String exerciseId,
    required String email,
  }) async {
    return await apiElearning.getExerciseResult(
      exerciseId: exerciseId,
      email: email,
    );
  }
}
