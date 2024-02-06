import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/question_model/question_answer_model.dart';

part 'question_answer_event.dart';
part 'question_answer_state.dart';

class QuestionAnswerBloc
    extends Bloc<QuestionAnswerEvent, QuestionAnswerState> {
  QuestionAnswerBloc() : super(QuestionAnswerInitial()) {
    on<SetQuestionAnswerEvent>((event, emit) {
      emit(SetQuestionAnswerLoading());
      emit(SetQuestionAnswerSuccess(questionAnswers: event.questionAnswers));
    });
  }
}
