part of 'question_answer_bloc.dart';

@immutable
sealed class QuestionAnswerState {}

final class QuestionAnswerInitial extends QuestionAnswerState {}

final class SetQuestionAnswerLoading extends QuestionAnswerState {}

final class SetQuestionAnswerSuccess extends QuestionAnswerState {
  final List<QuestionAnswer> questionAnswers;
  SetQuestionAnswerSuccess({required this.questionAnswers});
}
