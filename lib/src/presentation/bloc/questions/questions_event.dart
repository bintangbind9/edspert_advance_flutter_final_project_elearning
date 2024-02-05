part of 'questions_bloc.dart';

@immutable
sealed class QuestionsEvent {}

class GetQuestionsEvent extends QuestionsEvent {
  final GetQuestionsParams params;
  GetQuestionsEvent({required this.params});
}
