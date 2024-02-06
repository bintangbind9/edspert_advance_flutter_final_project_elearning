import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/general_values.dart';
import '../../../../domain/entities/exercise_model.dart';
import '../../../../domain/entities/question_model/question_answer_model.dart';
import '../../../../domain/entities/question_model/question_model.dart';
import '../../../../domain/usecases/get_questions_usecase.dart';
import '../../../bloc/bloc/question_answer_bloc.dart';
import '../../../bloc/question_index/question_index_bloc.dart';
import '../../../bloc/questions/questions_bloc.dart';
import '../../../widgets/simple_error_widget.dart';
import 'answer_option_widget.dart';
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
      context.read<QuestionIndexBloc>().add(SetQuestionIndexEvent(index: 0));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionsBloc, QuestionsState>(
      listenWhen: (previous, current) =>
          (previous is GetQuestionsLoading && current is GetQuestionsSuccess) ||
          (previous is GetQuestionsLoading &&
              current is GetQuestionsApiError) ||
          (previous is GetQuestionsLoading &&
              current is GetQuestionsInternalError),
      listener: (context, state) {
        if (state is GetQuestionsSuccess) {
          List<QuestionAnswer> questionAnswers = [];
          for (Question question in state.questions) {
            questionAnswers.add(QuestionAnswer(
              questionId: question.bankQuestionId!,
              answer: question.studentAnswer ?? GeneralValues.defaultAnswer,
            ));
          }
          context
              .read<QuestionAnswerBloc>()
              .add(SetQuestionAnswerEvent(questionAnswers: questionAnswers));
        }
      },
      child: Scaffold(
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
        body: Builder(
          builder: (context) {
            final getQuestionsState = context.watch<QuestionsBloc>().state;
            final questionIndex = context.watch<QuestionIndexBloc>().state;

            if (getQuestionsState is GetQuestionsSuccess) {
              Question question = getQuestionsState.questions[questionIndex];
              int questionsCount = getQuestionsState.questions.length;

              return Column(
                children: [
                  QuestionsIndexWidget(
                    itemCount: questionsCount,
                  ),
                  Text('Soal Nomor ${questionIndex + 1}'),
                  Expanded(
                    child: BlocBuilder<QuestionAnswerBloc, QuestionAnswerState>(
                      buildWhen: (previous, current) =>
                          (previous is SetQuestionAnswerLoading &&
                              current is SetQuestionAnswerSuccess),
                      builder: (context, qaState) {
                        if (qaState is SetQuestionAnswerSuccess) {
                          QuestionAnswer questionAnswer =
                              qaState.questionAnswers.singleWhere((e) =>
                                  e.questionId == question.bankQuestionId!);

                          return ListView(
                            children: [
                              HtmlWidget(
                                question.questionTitle!,
                              ),
                              AnswerOptionWidget(
                                questionId: question.bankQuestionId!,
                                questionAnswers: qaState.questionAnswers,
                                selectedAnswer: questionAnswer.answer,
                                textAnswer: question.optionA!,
                                labelAnswer: 'A',
                              ),
                              AnswerOptionWidget(
                                questionId: question.bankQuestionId!,
                                questionAnswers: qaState.questionAnswers,
                                selectedAnswer: questionAnswer.answer,
                                textAnswer: question.optionB!,
                                labelAnswer: 'B',
                              ),
                              AnswerOptionWidget(
                                questionId: question.bankQuestionId!,
                                questionAnswers: qaState.questionAnswers,
                                selectedAnswer: questionAnswer.answer,
                                textAnswer: question.optionC!,
                                labelAnswer: 'C',
                              ),
                              AnswerOptionWidget(
                                questionId: question.bankQuestionId!,
                                questionAnswers: qaState.questionAnswers,
                                selectedAnswer: questionAnswer.answer,
                                textAnswer: question.optionD!,
                                labelAnswer: 'D',
                              ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (questionIndex > 0) {
                            context.read<QuestionIndexBloc>().add(
                                SetQuestionIndexEvent(
                                    index: questionIndex - 1));
                          }
                        },
                        child: const Text('Sebelumnya'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (questionIndex < questionsCount - 1) {
                            context.read<QuestionIndexBloc>().add(
                                SetQuestionIndexEvent(
                                    index: questionIndex + 1));
                          }
                        },
                        child: const Text('Selanjutnya'),
                      ),
                    ],
                  ),
                ],
              );
            } else if (getQuestionsState is GetQuestionsInternalError) {
              return SimpleErrorWidget(message: getQuestionsState.message);
            } else if (getQuestionsState is GetQuestionsApiError) {
              return SimpleErrorWidget(message: getQuestionsState.message);
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
