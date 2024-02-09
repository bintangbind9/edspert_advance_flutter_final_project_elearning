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

class SubmitExerciseEvent extends ExercisesEvent {
  final SubmitExerciseAnswersReq req;
  SubmitExerciseEvent({required this.req});
}

class GetExerciseResultEvent extends ExercisesEvent {
  final GetExerciseResultParams params;
  GetExerciseResultEvent({required this.params});
}
