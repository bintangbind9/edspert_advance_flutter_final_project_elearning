import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../domain/entities/question_model/question_answer_model.dart';
import '../../../bloc/question_answer/question_answer_bloc.dart';

class AnswerOptionWidget extends StatelessWidget {
  const AnswerOptionWidget({
    super.key,
    required this.questionId,
    required this.questionAnswers,
    required this.selectedAnswer,
    required this.textAnswer,
    required this.labelAnswer,
  });

  final String questionId;
  final List<QuestionAnswer> questionAnswers;
  final String selectedAnswer;
  final String textAnswer;
  final String labelAnswer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        List<QuestionAnswer> currQuestionAnswers = questionAnswers;

        int indexQA =
            currQuestionAnswers.indexWhere((e) => e.questionId == questionId);
        currQuestionAnswers[indexQA] = QuestionAnswer(
          questionId: questionId,
          answer: labelAnswer,
        );
        context.read<QuestionAnswerBloc>().add(
              SetQuestionAnswerEvent(
                questionAnswers: currQuestionAnswers,
              ),
            );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 24,
        ),
        decoration: BoxDecoration(
          color: selectedAnswer == labelAnswer
              ? AppColors.primary
              : AppColors.grayscaleOffWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selectedAnswer == labelAnswer
                ? AppColors.primary
                : AppColors.grayscaleOutLine,
            width: 1,
          ),
        ),
        child: HtmlWidget(
          textAnswer,
          textStyle: TextStyle(
            color: selectedAnswer == labelAnswer
                ? AppColors.grayscaleOffWhite
                : AppColors.grayscaleBody,
          ),
        ),
      ),
    );
  }
}
