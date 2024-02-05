part of 'questions_bloc.dart';

@immutable
sealed class QuestionsState {}

final class QuestionsInitial extends QuestionsState {}

final class GetQuestionsLoading extends QuestionsState {}

final class GetQuestionsSuccess extends QuestionsState {
  final List<Question> questions;
  GetQuestionsSuccess({required this.questions});
}

final class GetQuestionsInternalError extends QuestionsState {
  final String message;
  GetQuestionsInternalError({required this.message});
}

final class GetQuestionsApiError extends QuestionsState {
  final String message;
  GetQuestionsApiError({required this.message});
}
