import 'package:edspert_advance_flutter_final_project_elearning/data/repository/course_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edspert_advance_flutter_final_project_elearning/data/model/course_model.dart';
import 'package:meta/meta.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  CoursesBloc() : super(CoursesInitial()) {
    on<GetCoursesEvent>((event, emit) async {
      emit(CoursesLoading());
      final courseRepository = CourseRepositoryImpl();
      final List<Course> courses = await courseRepository.getCourses(
        majorName: event.majorName,
        email: event.email,
      );

      emit(CoursesSuccess(courses: courses));
    });
  }
}
