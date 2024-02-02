import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/course_model.dart';
import '../../../domain/usecases/get_courses_usecase.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final GetCoursesUsecase getCoursesUsecase;

  CoursesBloc({required this.getCoursesUsecase}) : super(CoursesInitial()) {
    on<GetCoursesEvent>((event, emit) async {
      emit(GetCoursesLoading());

      final List<Course>? courses = await getCoursesUsecase(GetCoursesParams(
        majorName: event.majorName,
        email: event.email,
      ));

      if (courses != null) {
        emit(GetCoursesSuccess(courses: courses));
      } else {
        emit(GetCoursesError(message: 'Server Error.'));
      }
    });
  }
}
