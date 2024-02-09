import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/general_values.dart';
import '../../../../domain/entities/question_model/question_answer_model.dart';
import '../../../bloc/question_answer/question_answer_bloc.dart';
import '../../../bloc/question_index/question_index_bloc.dart';

class QuestionsIndexWidget extends StatelessWidget {
  final int itemCount;

  const QuestionsIndexWidget({
    super.key,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    double widgetHeight = 40;
    double circleIndexDiameter = 28;
    double separatorWidth = 10;

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: (widgetHeight - circleIndexDiameter) / 2,
            horizontal: 0,
          ),
          height: widgetHeight,
          color: AppColors.grayscaleOffWhite,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  SizedBox(width: separatorWidth / 2),
                  GestureDetector(
                    onTap: () => context
                        .read<QuestionIndexBloc>()
                        .add(SetQuestionIndexEvent(index: index)),
                    child: Builder(
                      builder: (context) {
                        final questionIndex =
                            context.watch<QuestionIndexBloc>().state;
                        final qaState =
                            context.watch<QuestionAnswerBloc>().state;

                        List<QuestionAnswer> questionAnswers = [];
                        if (qaState is SetQuestionAnswerSuccess) {
                          questionAnswers = qaState.questionAnswers;
                        }

                        QuestionAnswer questionAnswer =
                            questionAnswers.isNotEmpty
                                ? questionAnswers[index]
                                : QuestionAnswer(questionId: '', answer: '');
                        bool isFilled = questionAnswer.answer !=
                            GeneralValues.defaultAnswer;

                        return Container(
                          width: circleIndexDiameter,
                          height: circleIndexDiameter,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: questionIndex == index
                                ? AppColors.primary
                                : (isFilled
                                    ? AppColors.success
                                    : AppColors.grayscaleOffWhite),
                            border: Border.all(
                              color: questionIndex == index
                                  ? AppColors.primary
                                  : (isFilled
                                      ? AppColors.success
                                      : AppColors.primary),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: questionIndex == index
                                    ? AppColors.grayscaleOffWhite
                                    : (isFilled
                                        ? AppColors.grayscaleOffWhite
                                        : AppColors.primary),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: separatorWidth / 2),
                ],
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShadowContainer(
              widgetHeight: widgetHeight,
              separatorWidth: separatorWidth,
            ),
            ShadowContainer(
              widgetHeight: widgetHeight,
              separatorWidth: separatorWidth,
            ),
          ],
        ),
      ],
    );
  }
}

class ShadowContainer extends StatelessWidget {
  const ShadowContainer({
    super.key,
    required this.widgetHeight,
    required this.separatorWidth,
  });

  final double widgetHeight;
  final double separatorWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0,
      height: widgetHeight,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: separatorWidth,
            color: AppColors.grayscaleBackground,
            offset: const Offset(0, 0),
            spreadRadius: separatorWidth,
          ),
        ],
      ),
    );
  }
}
