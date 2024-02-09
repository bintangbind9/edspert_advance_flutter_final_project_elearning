import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/exercises/exercise_model.dart';
import '../../../domain/entities/exercises/exercise_result.dart';
import '../../../domain/entities/exercises/submit_exercise_answers_req.dart';
import '../../../domain/entities/response_model.dart';
import '../../../domain/usecases/get_exercise_result_usecase.dart';
import '../../../domain/usecases/get_exercises_usecase.dart';
import '../../../domain/usecases/submit_exercise_answers_usecase.dart';

part 'exercises_event.dart';
part 'exercises_state.dart';

class ExercisesBloc extends Bloc<ExercisesEvent, ExercisesState> {
  final GetExercisesUsecase getExercisesUsecase;
  final SubmitExerciseAnswersUsecase submitExerciseAnswersUsecase;
  final GetExerciseResultUsecase getExerciseResultUsecase;

  ExercisesBloc({
    required this.getExercisesUsecase,
    required this.submitExerciseAnswersUsecase,
    required this.getExerciseResultUsecase,
  }) : super(ExercisesInitial()) {
    on<GetExercisesByCourseIdAndEmailEvent>((event, emit) async {
      emit(ExercisesInitial());
      emit(GetExercisesLoading());

      final List<Exercise>? exercises =
          await getExercisesUsecase.call(GetExercisesParams(
        courseId: event.courseId,
        email: event.email,
      ));

      if (exercises != null) {
        emit(GetExercisesSuccess(exercises: exercises));
      } else {
        emit(GetExercisesError(message: 'Server Error.'));
      }
    });

    on<SubmitExerciseEvent>((event, emit) async {
      emit(SubmitExerciseLoading());

      final ResponseModel<void>? responseModel =
          await submitExerciseAnswersUsecase.call(event.req);

      if (responseModel != null) {
        emit(SubmitExerciseSuccess(response: responseModel));
      } else {
        emit(SubmitExerciseError(message: 'Server Error.'));
      }
    });

    on<GetExerciseResultEvent>((event, emit) async {
      emit(GetExerciseResultLoading());

      final responseModel = await getExerciseResultUsecase.call(event.params);

      if (responseModel != null) {
        if (responseModel.status == 1 && responseModel.data != null) {
          emit(GetExerciseResultSuccess(exerciseResult: responseModel.data!));
        } else {
          emit(GetExerciseResultApiError(
            message: responseModel.message ?? 'Get Exercise Result Failed',
          ));
        }
      } else {
        emit(GetExerciseResultInternalError(
          message: 'Oops! Get Exercise Result Failed. Something went wrong.',
        ));
      }
    });
  }
}
