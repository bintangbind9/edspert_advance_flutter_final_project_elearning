part of 'exercises_bloc.dart';

@immutable
sealed class ExercisesState {}

final class ExercisesInitial extends ExercisesState {}

final class GetExercisesLoading extends ExercisesState {}

final class GetExercisesSuccess extends ExercisesState {
  final List<Exercise> exercises;
  GetExercisesSuccess({required this.exercises});
}

final class GetExercisesError extends ExercisesState {
  final String message;
  GetExercisesError({required this.message});
}
