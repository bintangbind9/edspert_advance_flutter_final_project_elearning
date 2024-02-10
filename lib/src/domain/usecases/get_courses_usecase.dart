import '../entities/course_model.dart';
import '../repositories/course_repository.dart';
import 'usecase.dart';

class GetCoursesUsecase
    implements UseCase<Future<List<Course>?>, GetCoursesParams> {
  final CourseRepository repository;

  GetCoursesUsecase({required this.repository});

  @override
  Future<List<Course>?> call(params) async {
    return await repository.getCourses(
      majorName: params.majorName,
      email: params.email,
    );
  }
}

class GetCoursesParams {
  final String majorName;
  final String email;

  GetCoursesParams({
    required this.majorName,
    required this.email,
  });
}
