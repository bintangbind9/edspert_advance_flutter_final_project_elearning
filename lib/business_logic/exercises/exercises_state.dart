part of 'exercises_bloc.dart';

@immutable
sealed class ExercisesState {}

final class ExercisesInitial extends ExercisesState {}

final class ExercisesLoading extends ExercisesState {}

final class ExercisesSuccess extends ExercisesState {
  final List<Exercise> exercises;
  ExercisesSuccess({required this.exercises});
}

final class ExercisesError extends ExercisesState {
  final String message;
  ExercisesError({required this.message});
}
