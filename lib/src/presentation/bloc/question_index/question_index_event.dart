part of 'question_index_bloc.dart';

@immutable
sealed class QuestionIndexEvent {}

class SetQuestionIndexEvent extends QuestionIndexEvent {
  final int index;
  SetQuestionIndexEvent({required this.index});
}
