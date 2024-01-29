part of 'exercises_bloc.dart';

@immutable
sealed class ExercisesEvent {}

class GetExercisesByCourseIdAndEmailEvent extends ExercisesEvent {
  final String courseId;
  final String email;
  GetExercisesByCourseIdAndEmailEvent({
    required this.courseId,
    required this.email,
  });
}
