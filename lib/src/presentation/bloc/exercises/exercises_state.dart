part of 'exercises_bloc.dart';

@immutable
sealed class ExercisesState {}

final class ExercisesInitial extends ExercisesState {}

// Get Exercises
final class GetExercisesLoading extends ExercisesState {}

final class GetExercisesSuccess extends ExercisesState {
  final List<Exercise> exercises;
  GetExercisesSuccess({required this.exercises});
}

final class GetExercisesError extends ExercisesState {
  final String message;
  GetExercisesError({required this.message});
}

// Submit Exercise
final class SubmitExerciseLoading extends ExercisesState {}

final class SubmitExerciseSuccess extends ExercisesState {
  final ResponseModel<void> response;
  SubmitExerciseSuccess({required this.response});
}

final class SubmitExerciseError extends ExercisesState {
  final String message;
  SubmitExerciseError({required this.message});
}

// Get Exercise Result
final class GetExerciseResultLoading extends ExercisesState {}

final class GetExerciseResultSuccess extends ExercisesState {
  final ExerciseResult exerciseResult;
  GetExerciseResultSuccess({required this.exerciseResult});
}

final class GetExerciseResultApiError extends ExercisesState {
  final String message;
  GetExerciseResultApiError({required this.message});
}

final class GetExerciseResultInternalError extends ExercisesState {
  final String message;
  GetExerciseResultInternalError({required this.message});
}
