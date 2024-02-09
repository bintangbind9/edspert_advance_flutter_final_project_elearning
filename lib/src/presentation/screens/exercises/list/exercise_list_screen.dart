import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/styles.dart';
import '../../../../domain/entities/exercises/exercise_model.dart';
import '../../../bloc/exercises/exercises_bloc.dart';
import '../../../widgets/sub_section.dart';
import 'exercise_empty.dart';
import 'exercise_grid_item.dart';

class ExerciseListScreen extends StatefulWidget {
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
  State<ExerciseListScreen> createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<ExerciseListScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        context.read<ExercisesBloc>().add(
              GetExercisesByCourseIdAndEmailEvent(
                courseId: widget.courseId,
                email: widget.email,
              ),
            );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.grayscaleOffWhite,
        backgroundColor: AppColors.primary,
        centerTitle: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          widget.courseName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<ExercisesBloc, ExercisesState>(
        buildWhen: (previous, current) =>
            (previous is ExercisesInitial && current is GetExercisesLoading) ||
            (previous is GetExercisesLoading &&
                current is GetExercisesSuccess) ||
            (previous is GetExercisesLoading && current is GetExercisesError),
        builder: (context, state) {
          if (state is GetExercisesSuccess) {
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 20 / 16,
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
          } else if (state is GetExercisesError) {
            return Center(child: Text(state.message));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
