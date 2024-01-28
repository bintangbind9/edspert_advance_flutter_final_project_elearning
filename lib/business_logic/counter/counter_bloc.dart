import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial(result: 0)) {
    on<IncrementCounterEvent>((event, emit) {
      emit(CounterLoading());
      emit(CounterSuccess(result: event.count + 1));
    });
    on<DecrementCounterEvent>((event, emit) {
      emit(CounterLoading());
      emit(CounterSuccess(result: event.count - 1));
    });
  }
}
