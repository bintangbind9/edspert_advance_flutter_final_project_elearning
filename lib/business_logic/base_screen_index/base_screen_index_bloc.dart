import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'base_screen_index_event.dart';

class BaseScreenIndexBloc extends Bloc<BaseScreenIndexEvent, int> {
  BaseScreenIndexBloc() : super(0) {
    on<BaseScreenIndexEventChange>((event, emit) {
      emit(event.index);
    });
  }
}
