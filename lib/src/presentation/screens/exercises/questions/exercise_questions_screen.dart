import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../domain/entities/exercise_model.dart';
import '../../../../domain/usecases/get_questions_usecase.dart';
import '../../../bloc/questions/questions_bloc.dart';
import '../../../widgets/simple_error_widget.dart';
import 'questions_index_widget.dart';

// https://stackoverflow.com/questions/72448181/how-to-properly-use-the-findchildindexcallback-in-listview-builder-flutter

class ExerciseQuestionsScreen extends StatefulWidget {
  final Exercise exercise;
  final String email;

  const ExerciseQuestionsScreen({
    super.key,
    required this.exercise,
    required this.email,
  });

  @override
  State<ExerciseQuestionsScreen> createState() =>
      _ExerciseQuestionsScreenState();
}

class _ExerciseQuestionsScreenState extends State<ExerciseQuestionsScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<QuestionsBloc>().add(
            GetQuestionsEvent(
              params: GetQuestionsParams(
                exerciseId: widget.exercise.exerciseId!,
                email: widget.email,
              ),
            ),
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayscaleBackgroundQuestion,
      appBar: AppBar(
        foregroundColor: AppColors.grayscaleOffWhite,
        backgroundColor: AppColors.primary,
        centerTitle: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          widget.exercise.exerciseTitle ?? 'No Title',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<QuestionsBloc, QuestionsState>(
        builder: (context, state) {
          if (state is GetQuestionsSuccess) {
            return Column(
              children: [
                QuestionsIndexWidget(
                  questions: state.questions,
                  isFilled: false,
                  isSelected: false,
                ),
              ],
            );
          } else if (state is GetQuestionsInternalError) {
            return SimpleErrorWidget(message: state.message);
          } else if (state is GetQuestionsApiError) {
            return SimpleErrorWidget(message: state.message);
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
