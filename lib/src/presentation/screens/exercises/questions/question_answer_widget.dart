import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../common/constants/styles.dart';
import '../../../../domain/entities/question_model/question_answer_model.dart';
import '../../../../domain/entities/question_model/question_model.dart';
import '../../../bloc/question_answer/question_answer_bloc.dart';
import 'answer_option_widget.dart';

class QuestionAnswerWidget extends StatelessWidget {
  final int questionIndex;
  final Question question;

  const QuestionAnswerWidget({
    super.key,
    required this.questionIndex,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Styles.mainPadding),
        child: BlocBuilder<QuestionAnswerBloc, QuestionAnswerState>(
          buildWhen: (previous, current) =>
              (previous is SetQuestionAnswerLoading &&
                  current is SetQuestionAnswerSuccess),
          builder: (context, qaState) {
            if (qaState is SetQuestionAnswerSuccess) {
              QuestionAnswer questionAnswer = qaState.questionAnswers
                  .singleWhere((e) => e.questionId == question.bankQuestionId!);

              return ListView(
                children: [
                  HtmlWidget(
                    question.questionTitle!,
                    customStylesBuilder: (element) {
                      return {'text-align': 'justify'};
                    },
                  ),
                  const SizedBox(height: Styles.mainPadding),
                  AnswerOptionWidget(
                    questionId: question.bankQuestionId!,
                    questionAnswers: qaState.questionAnswers,
                    selectedAnswer: questionAnswer.answer,
                    textAnswer: question.optionA!,
                    labelAnswer: 'A',
                  ),
                  const SizedBox(height: Styles.mainPadding / 2),
                  AnswerOptionWidget(
                    questionId: question.bankQuestionId!,
                    questionAnswers: qaState.questionAnswers,
                    selectedAnswer: questionAnswer.answer,
                    textAnswer: question.optionB!,
                    labelAnswer: 'B',
                  ),
                  const SizedBox(height: Styles.mainPadding / 2),
                  AnswerOptionWidget(
                    questionId: question.bankQuestionId!,
                    questionAnswers: qaState.questionAnswers,
                    selectedAnswer: questionAnswer.answer,
                    textAnswer: question.optionC!,
                    labelAnswer: 'C',
                  ),
                  const SizedBox(height: Styles.mainPadding / 2),
                  AnswerOptionWidget(
                    questionId: question.bankQuestionId!,
                    questionAnswers: qaState.questionAnswers,
                    selectedAnswer: questionAnswer.answer,
                    textAnswer: question.optionD!,
                    labelAnswer: 'D',
                  ),
                  const SizedBox(height: Styles.mainPadding / 2),
                  AnswerOptionWidget(
                    questionId: question.bankQuestionId!,
                    questionAnswers: qaState.questionAnswers,
                    selectedAnswer: questionAnswer.answer,
                    textAnswer: question.optionE!,
                    labelAnswer: 'E',
                  ),
                ],
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
