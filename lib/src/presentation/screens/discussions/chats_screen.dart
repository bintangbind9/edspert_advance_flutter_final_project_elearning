import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/general_values.dart';
import '../../../common/constants/styles.dart';
import '../../../domain/entities/firestore/firestore_group_model.dart';
import '../../../domain/entities/firestore/firestore_message_model.dart';
import '../../../domain/usecases/send_message_with_files_usecase.dart';
import '../../bloc/discussion/discussion_bloc.dart';
import '../../bloc/images/images_bloc.dart';
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
      context.read<ImagesBloc>().add(SetImagesEvent(files: const []));
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
    Map<String, Uint8List> currFiles = {};
    bool isMapFilesDone = true;

    return MultiBlocListener(
      listeners: [
        BlocListener<ImagesBloc, ImagesState>(
          listenWhen: (previous, current) =>
              (previous is ImagesInitial && current is ImagesDone),
          listener: (context, state) async {
            if (state is ImagesDone) {
              // reset
              isMapFilesDone = false;
              currFiles = {};

              for (int i = 0; i < state.files.length; i++) {
                final String fileExt = state.files[i].path.split('.').last;
                final String fileName =
                    '${DateTime.now().millisecondsSinceEpoch}_${i + 1}.$fileExt';
                currFiles[fileName] = await state.files[i].readAsBytes();
              }

              isMapFilesDone = true;
            }
          },
        ),
        BlocListener<DiscussionBloc, DiscussionState>(
          listenWhen: (previous, current) =>
              (previous is DiscussionInitial &&
                  current is SendMessageWithFilesLoading) ||
              (previous is SendMessageWithFilesLoading &&
                  current is SendMessageWithFilesSuccess) ||
              (previous is SendMessageWithFilesLoading &&
                  current is SendMessageWithFilesError),
          listener: (context, state) {
            if (state is SendMessageWithFilesSuccess) {
              context.read<ImagesBloc>().add(SetImagesEvent(files: const []));
            }
          },
        ),
      ],
      child: GestureDetector(
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
                            List<FirestoreMessageModel> messages =
                                snapshot.data!;

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
                child: Column(
                  children: [
                    BlocBuilder<ImagesBloc, ImagesState>(
                      buildWhen: (previous, current) =>
                          (previous is ImagesInitial && current is ImagesDone),
                      builder: (context, state) {
                        if (state is ImagesDone) {
                          if (state.files.isNotEmpty) {
                            return Container(
                              height: 200,
                              padding: const EdgeInsets.all(Styles.mainPadding),
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: state.files.length,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Image.file(File(state.files[index].path)),
                                      GestureDetector(
                                        onTap: () {
                                          List<XFile> currFiles = state.files;
                                          currFiles.removeAt(index);
                                          context.read<ImagesBloc>().add(
                                              SetImagesEvent(files: currFiles));
                                        },
                                        child: const Icon(Icons.cancel),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          }

                          return const SizedBox();
                        }

                        return const SizedBox();
                      },
                    ),
                    Row(
                      children: [
                        IconButton(
                          color: AppColors.primary,
                          onPressed: () {
                            context.read<ImagesBloc>().add(PickImagesEvent());
                          },
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
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  context.read<ImagesBloc>().add(
                                        PickImageEvent(
                                          imageSource: ImageSource.camera,
                                        ),
                                      );
                                },
                                child: const Icon(Icons.camera_alt),
                              ),
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
                                borderRadius: BorderRadius.circular(
                                    Styles.mainBorderRadius),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 0,
                                  style: BorderStyle.none,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                ),
                                borderRadius: BorderRadius.circular(
                                    Styles.mainBorderRadius),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          color: AppColors.primary,
                          onPressed: () {
                            if (chatTextEditingController.text
                                    .trim()
                                    .isNotEmpty &&
                                isMapFilesDone) {
                              context.read<DiscussionBloc>().add(
                                    SendMessageWithFilesEvent(
                                      params: SendMessageWithFilesParams(
                                        groupId: widget.group.groupId,
                                        message: FirestoreMessageModel(
                                          email: FirebaseAuth.instance
                                                  .currentUser!.email ??
                                              'Anonymous',
                                          message:
                                              chatTextEditingController.text,
                                          time: Timestamp.now(),
                                        ),
                                        files: currFiles,
                                        storagePath: StoragePath.chatImage,
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
