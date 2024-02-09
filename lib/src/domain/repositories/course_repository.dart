import '../entities/course_model.dart';
import '../entities/exercise_model.dart';
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
}
