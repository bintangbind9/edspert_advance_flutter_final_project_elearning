part of 'counter_bloc.dart';

@immutable
sealed class CounterState {}

final class CounterInitial extends CounterState {
  final int result;
  CounterInitial({required this.result});
}

final class CounterLoading extends CounterState {}

final class CounterSuccess extends CounterState {
  final int result;
  CounterSuccess({required this.result});
}

final class CounterError extends CounterState {
  final String? errorMessage;
  CounterError({required this.errorMessage});
}
