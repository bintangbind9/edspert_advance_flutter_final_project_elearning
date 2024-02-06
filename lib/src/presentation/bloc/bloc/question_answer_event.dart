part of 'question_answer_bloc.dart';

@immutable
sealed class QuestionAnswerEvent {}

class SetQuestionAnswerEvent extends QuestionAnswerEvent {
  final List<QuestionAnswer> questionAnswers;
  SetQuestionAnswerEvent({required this.questionAnswers});
}
