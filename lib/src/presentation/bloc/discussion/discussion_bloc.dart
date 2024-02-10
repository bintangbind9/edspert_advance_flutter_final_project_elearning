import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/firestore/firestore_group_model.dart';
import '../../../domain/entities/firestore/firestore_message_model.dart';
import '../../../domain/usecases/get_groups_stream_usecase.dart';
import '../../../domain/usecases/get_messages_stream_usecase.dart';
import '../../../domain/usecases/send_message_usecase.dart';
import '../../../domain/usecases/send_message_with_files_usecase.dart';

part 'discussion_event.dart';
part 'discussion_state.dart';

class DiscussionBloc extends Bloc<DiscussionEvent, DiscussionState> {
  final GetGroupsStreamUsecase getGroupsStreamUsecase;
  final GetMessagesStreamUsecase getMessagesStreamUsecase;
  final SendMessageUsecase sendMessageUsecase;
  final SendMessageWithFilesUsecase sendMessageWithFilesUsecase;

  DiscussionBloc({
    required this.getGroupsStreamUsecase,
    required this.getMessagesStreamUsecase,
    required this.sendMessageUsecase,
    required this.sendMessageWithFilesUsecase,
  }) : super(DiscussionInitial()) {
    on<GetGroupsStreamEvent>((event, emit) {
      emit(DiscussionInitial());
      emit(GetGroupsStreamLoading());

      final groupsStream = getGroupsStreamUsecase.call(null);

      emit(GetGroupsStreamSuccess(groupsStream: groupsStream));
    });

    on<GetMessagesStreamEvent>((event, emit) {
      emit(DiscussionInitial());
      emit(GetMessagesStreamLoading());

      final messagesStream = getMessagesStreamUsecase.call(event.groupId);

      emit(GetMessagesStreamSuccess(messagesStream: messagesStream));
    });

    on<SendMessageEvent>((event, emit) async {
      emit(DiscussionInitial());
      emit(SendMessageLoading());

      final bool isSuccess = await sendMessageUsecase.call(event.params);

      if (isSuccess) {
        emit(SendMessageSuccess());
      } else {
        emit(SendMessageError(
          message: 'Failed send message. Something went wrong!',
        ));
      }
    });

    on<SendMessageWithFilesEvent>((event, emit) async {
      emit(DiscussionInitial());
      emit(SendMessageWithFilesLoading());

      final bool isSuccess = await sendMessageWithFilesUsecase.call(
        event.params,
      );

      if (isSuccess) {
        emit(SendMessageWithFilesSuccess());
      } else {
        emit(SendMessageWithFilesError(
          message: 'Failed send message with files. Something went wrong!',
        ));
      }
    });
  }
}
