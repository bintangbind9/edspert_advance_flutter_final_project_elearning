import 'package:edspert_advance_flutter_final_project_elearning/data/model/response_model.dart';
import 'package:edspert_advance_flutter_final_project_elearning/data/repository/exercise_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/exercise_model.dart';

part 'exercises_event.dart';
part 'exercises_state.dart';

class ExercisesBloc extends Bloc<ExercisesEvent, ExercisesState> {
  ExercisesBloc() : super(ExercisesInitial()) {
    on<GetExercisesByCourseIdAndEmailEvent>((event, emit) async {
      emit(ExercisesLoading());

      final ExerciseRepositoryImpl exerciseRepository =
          ExerciseRepositoryImpl();
      final ResponseModel<List<Exercise>> exerciseResponse =
          await exerciseRepository.getExercisesByCourseIdAndEmail(
        courseId: event.courseId,
        email: event.email,
      );

      emit(ExercisesSuccess(exercises: exerciseResponse.data ?? []));

      /*
      if ((exerciseResponse.status ?? 0) == 0) {
        emit(ExercisesError(message: exerciseResponse.message ?? 'Error'));
      } else {
        emit(ExercisesSuccess(exercises: exerciseResponse.data ?? []));
      }
      */
    });
  }
}
