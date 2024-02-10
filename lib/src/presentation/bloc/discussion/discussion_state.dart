part of 'discussion_bloc.dart';

@immutable
sealed class DiscussionState {}

final class DiscussionInitial extends DiscussionState {}

// Get Groups Stream
final class GetGroupsStreamLoading extends DiscussionState {}

final class GetGroupsStreamSuccess extends DiscussionState {
  final Stream<List<FirestoreGroupModel>> groupsStream;
  GetGroupsStreamSuccess({required this.groupsStream});
}

// Get Messages Stream
final class GetMessagesStreamLoading extends DiscussionState {}

final class GetMessagesStreamSuccess extends DiscussionState {
  final Stream<List<FirestoreMessageModel>> messagesStream;
  GetMessagesStreamSuccess({required this.messagesStream});
}

// Send Message

final class SendMessageLoading extends DiscussionState {}

final class SendMessageSuccess extends DiscussionState {}

final class SendMessageError extends DiscussionState {
  final String message;
  SendMessageError({required this.message});
}

// Send Message with Files

final class SendMessageWithFilesLoading extends DiscussionState {}

final class SendMessageWithFilesSuccess extends DiscussionState {}

final class SendMessageWithFilesError extends DiscussionState {
  final String message;
  SendMessageWithFilesError({required this.message});
}
