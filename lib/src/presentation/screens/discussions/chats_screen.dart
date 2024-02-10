import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/styles.dart';
import '../../../domain/entities/firestore/firestore_group_model.dart';
import '../../../domain/entities/firestore/firestore_message_model.dart';
import '../../../domain/usecases/send_message_usecase.dart';
import '../../bloc/discussion/discussion_bloc.dart';
import 'chat_item_widget.dart';

class ChatsScreen extends StatefulWidget {
  final FirestoreGroupModel group;

  const ChatsScreen({
    super.key,
    required this.group,
  });

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  TextEditingController chatTextEditingController = TextEditingController();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DiscussionBloc>().add(
            GetMessagesStreamEvent(
              groupId: widget.group.groupId,
            ),
          );
    });
    super.initState();
  }

  @override
  void dispose() {
    chatTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.group.groupName),
          centerTitle: true,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.grayscaleOffWhite,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<DiscussionBloc, DiscussionState>(
                buildWhen: (previous, current) =>
                    (previous is DiscussionInitial &&
                        current is GetMessagesStreamLoading) ||
                    (previous is GetMessagesStreamLoading &&
                        current is GetMessagesStreamSuccess),
                builder: (context, state) {
                  if (state is GetMessagesStreamSuccess) {
                    return StreamBuilder(
                      stream: state.messagesStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<FirestoreMessageModel> messages = snapshot.data!;

                          return ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              FirestoreMessageModel message = messages[index];

                              return ChatItemWidget(message: message);
                            },
                          );
                        }

                        return const Center(child: Text('No Message'));
                      },
                    );
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: AppColors.grayscaleOffWhite,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: AppColors.disable,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    color: AppColors.primary,
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                  ),
                  Expanded(
                    child: TextField(
                      controller: chatTextEditingController,
                      cursorColor: AppColors.primary,
                      minLines: 1,
                      maxLines: 4,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        filled: true,
                        fillColor: AppColors.grayscaleInputBackground,
                        suffixIcon: const Icon(Icons.camera_alt),
                        suffixIconColor: AppColors.primary,
                        hintText: 'Ketuk untuk menulis...',
                        hintStyle:
                            const TextStyle(color: AppColors.disableText),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 0,
                            style: BorderStyle.none,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                          borderRadius:
                              BorderRadius.circular(Styles.mainBorderRadius),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 0,
                            style: BorderStyle.none,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                          borderRadius:
                              BorderRadius.circular(Styles.mainBorderRadius),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    color: AppColors.primary,
                    onPressed: () {
                      if (chatTextEditingController.text.trim().isNotEmpty) {
                        context.read<DiscussionBloc>().add(
                              SendMessageEvent(
                                params: SendMessageParams(
                                  groupId: widget.group.groupId,
                                  message: FirestoreMessageModel(
                                    email: FirebaseAuth
                                            .instance.currentUser!.email ??
                                        'Anonymous',
                                    message: chatTextEditingController.text,
                                    time: Timestamp.now(),
                                  ),
                                ),
                              ),
                            );
                        chatTextEditingController.clear();
                      }
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
