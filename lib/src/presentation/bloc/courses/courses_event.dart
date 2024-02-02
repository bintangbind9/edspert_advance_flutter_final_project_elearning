part of 'courses_bloc.dart';

@immutable
sealed class CoursesEvent {}

class GetCoursesEvent extends CoursesEvent {
  final String majorName;
  final String email;
  GetCoursesEvent({required this.majorName, required this.email});
}

// Example other CoursesEvent
class GetCoursesDetailEvent extends CoursesEvent {}
