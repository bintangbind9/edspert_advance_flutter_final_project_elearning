import 'package:edspert_advance_flutter_final_project_elearning/data/model/course_model.dart';

abstract class CourseRepository {
  Future<List<Course>> getCourses({
    required String majorName,
    required String email,
  });
}
