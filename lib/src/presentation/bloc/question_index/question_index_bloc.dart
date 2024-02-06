import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'question_index_event.dart';

class QuestionIndexBloc extends Bloc<QuestionIndexEvent, int> {
  QuestionIndexBloc() : super(0) {
    on<SetQuestionIndexEvent>((event, emit) {
      emit(event.index);
    });
  }
}
