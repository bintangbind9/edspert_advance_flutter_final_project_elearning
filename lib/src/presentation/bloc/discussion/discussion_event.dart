part of 'discussion_bloc.dart';

@immutable
sealed class DiscussionEvent {}

class GetGroupsStreamEvent extends DiscussionEvent {}

class GetMessagesStreamEvent extends DiscussionEvent {
  final String groupId;
  GetMessagesStreamEvent({required this.groupId});
}

class SendMessageEvent extends DiscussionEvent {
  final SendMessageParams params;
  SendMessageEvent({required this.params});
}

class SendMessageWithFilesEvent extends DiscussionEvent {
  final SendMessageWithFilesParams params;
  SendMessageWithFilesEvent({required this.params});
}
