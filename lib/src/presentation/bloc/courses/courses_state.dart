part of 'courses_bloc.dart';

@immutable
sealed class CoursesState {}

final class CoursesInitial extends CoursesState {}

// Get Courses
final class GetCoursesLoading extends CoursesState {}

final class GetCoursesSuccess extends CoursesState {
  final List<Course> courses;
  GetCoursesSuccess({required this.courses});
}

final class GetCoursesError extends CoursesState {
  final String message;
  GetCoursesError({required this.message});
}

// Get Courses Detail (Example other CoursesState)
final class GetCoursesDetailLoading extends CoursesState {}

final class GetCoursesDetailSuccess extends CoursesState {
  final Course course;
  GetCoursesDetailSuccess({required this.course});
}

final class GetCoursesDetailError extends CoursesState {
  final String message;
  GetCoursesDetailError({required this.message});
}
