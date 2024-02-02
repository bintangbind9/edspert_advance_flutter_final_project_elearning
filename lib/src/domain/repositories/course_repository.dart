import '../entities/course_model.dart';

abstract class CourseRepository {
  Future<List<Course>?> getCourses({
    required String majorName,
    required String email,
  });
}
