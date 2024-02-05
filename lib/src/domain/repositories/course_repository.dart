import '../entities/course_model.dart';
import '../entities/question_model.dart';
import '../entities/response_model.dart';

abstract class CourseRepository {
  Future<List<Course>?> getCourses({
    required String majorName,
    required String email,
  });

  Future<ResponseModel<List<Question>>?> getQuestions({
    required String exerciseId,
    required String email,
  });
}
