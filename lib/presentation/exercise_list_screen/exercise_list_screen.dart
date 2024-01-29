import 'package:edspert_advance_flutter_final_project_elearning/business_logic/exercises/exercises_bloc.dart';
import 'package:edspert_advance_flutter_final_project_elearning/common/constants/styles.dart';
import 'package:edspert_advance_flutter_final_project_elearning/presentation/exercise_list_screen/exercise_empty.dart';
import 'package:edspert_advance_flutter_final_project_elearning/presentation/exercise_list_screen/exercise_grid_item.dart';
import 'package:edspert_advance_flutter_final_project_elearning/presentation/widgets/sub_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/constants/app_colors.dart';
import '../../data/model/exercise_model.dart';

class ExerciseListScreen extends StatelessWidget {
  final String courseId;
  final String courseName;
  final String email;

  const ExerciseListScreen({
    super.key,
    required this.courseId,
    required this.courseName,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExercisesBloc()
        ..add(
          GetExercisesByCourseIdAndEmailEvent(
            courseId: courseId,
            email: email,
          ),
        ),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: AppColors.grayscaleOffWhite,
          backgroundColor: AppColors.primary,
          centerTitle: false,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(
            courseName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocBuilder<ExercisesBloc, ExercisesState>(
          builder: (context, state) {
            if (state is ExercisesSuccess) {
              if (state.exercises.isEmpty) {
                return const ExerciseEmpty();
              }

              return SubSection(
                horizontalTitlePadding: Styles.mainPadding,
                verticalTitlePadding: Styles.mainPadding,
                title: 'Pilih Paket Soal',
                child: Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.only(
                      left: Styles.mainPadding,
                      right: Styles.mainPadding,
                      bottom: Styles.mainPadding,
                    ),
                    shrinkWrap: true,
                    itemCount: state.exercises.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.4,
                      mainAxisSpacing: Styles.mainPadding,
                      crossAxisSpacing: Styles.mainPadding,
                    ),
                    itemBuilder: (context, index) {
                      final Exercise exercise = state.exercises[index];
                      return ExerciseGridItem(exercise: exercise);
                    },
                  ),
                ),
              );
            } else if (state is ExercisesError) {
              return Center(child: Text(state.message));
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
