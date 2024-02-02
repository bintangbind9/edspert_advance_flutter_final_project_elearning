import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/exercise_model.dart';
import '../../../domain/usecases/get_exercises_usecase.dart';

part 'exercises_event.dart';
part 'exercises_state.dart';

class ExercisesBloc extends Bloc<ExercisesEvent, ExercisesState> {
  final GetExercisesUsecase getExercisesUsecase;

  ExercisesBloc({required this.getExercisesUsecase})
      : super(ExercisesInitial()) {
    on<GetExercisesByCourseIdAndEmailEvent>((event, emit) async {
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
  }
}
