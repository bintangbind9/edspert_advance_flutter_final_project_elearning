import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/utils/time_ago.dart';
import '../../../domain/entities/firestore/firestore_group_model.dart';
import '../../bloc/discussion/discussion_bloc.dart';
import 'chats_screen.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DiscussionBloc>().add(GetGroupsStreamEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grup Diskusi'),
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
      body: BlocBuilder<DiscussionBloc, DiscussionState>(
        buildWhen: (previous, current) =>
            (previous is DiscussionInitial &&
                current is GetGroupsStreamLoading) ||
            (previous is GetGroupsStreamLoading &&
                current is GetGroupsStreamSuccess),
        builder: (context, state) {
          if (state is GetGroupsStreamSuccess) {
            return StreamBuilder(
              stream: state.groupsStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<FirestoreGroupModel> groups = snapshot.data!;

                  return ListView.builder(
                    itemCount: groups.length,
                    itemBuilder: (context, index) {
                      FirestoreGroupModel group = groups[index];

                      return ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.secondary,
                          child: Text(
                            group.groupName.substring(0, 1).toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        title: Text(
                          group.groupName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          "${group.recentMessageSender}: ${group.recentMessage}",
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(
                          TimeAgo().getIdShortTimeMessage(
                            group.recentMessageTime.toDate(),
                          ),
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatsScreen(group: group),
                          ),
                        ),
                      );
                    },
                  );
                }

                return const Center(child: Text('No Discussion Groups'));
              },
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
