import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/question_model/question_model.dart';
import '../../../domain/usecases/get_questions_usecase.dart';

part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final GetQuestionsUsecase getQuestionsUsecase;

  QuestionsBloc({required this.getQuestionsUsecase})
      : super(QuestionsInitial()) {
    on<GetQuestionsEvent>((event, emit) async {
      emit(GetQuestionsLoading());

      final responseModel = await getQuestionsUsecase(GetQuestionsParams(
        exerciseId: event.params.exerciseId,
        email: event.params.email,
      ));

      if (responseModel != null) {
        if (responseModel.status == 1 && responseModel.data != null) {
          emit(GetQuestionsSuccess(questions: responseModel.data!));
        } else {
          emit(GetQuestionsApiError(
            message: responseModel.message ?? 'Get Questions Failed',
          ));
        }
      } else {
        emit(GetQuestionsInternalError(
          message: 'Oops! Get Questions Failed. Something went wrong.',
        ));
      }
    });
  }
}
