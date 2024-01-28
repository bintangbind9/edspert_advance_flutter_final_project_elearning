part of 'counter_bloc.dart';

@immutable
sealed class CounterEvent {}

class IncrementCounterEvent extends CounterEvent {
  final int count;
  IncrementCounterEvent({required this.count});
}

class DecrementCounterEvent extends CounterEvent {
  final int count;
  DecrementCounterEvent({required this.count});
}
