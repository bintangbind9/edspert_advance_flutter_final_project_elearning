import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/styles.dart';
import '../../../common/utils/time_ago.dart';
import '../../../domain/entities/firestore/firestore_message_model.dart';

class ChatItemWidget extends StatelessWidget {
  final FirestoreMessageModel message;

  const ChatItemWidget({
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isHasFile = message.files!.isNotEmpty;
    bool isSender = message.email == FirebaseAuth.instance.currentUser!.email;

    return Padding(
      padding: const EdgeInsets.all(Styles.mainPadding / 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            !isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(
            isSender ? 'Saya' : message.email,
            style: TextStyle(
              color: isSender ? AppColors.mint : Colors.black,
            ),
          ),
          if (isHasFile)
            Card(
              color: isSender ? AppColors.primary : AppColors.grayscaleOffWhite,
              child: Container(
                padding: const EdgeInsets.all(12.0),
                width: 200,
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: message.files!.length,
                  itemBuilder: (context, index) {
                    String imgUrl = message.files![index];
                    return Image.network(imgUrl);
                  },
                ),
              ),
            ),
          Card(
            color: isSender ? AppColors.primary : AppColors.grayscaleOffWhite,
            margin: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: isSender
                    ? const Radius.circular(0)
                    : const Radius.circular(12),
                bottomLeft: const Radius.circular(12),
                topLeft: !isSender
                    ? const Radius.circular(0)
                    : const Radius.circular(12),
                topRight: const Radius.circular(12),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              child: Text(
                message.message,
                style: TextStyle(
                  color: isSender ? AppColors.grayscaleOffWhite : Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            TimeAgo().getIdTimeMessage(message.time.toDate()),
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.disableText,
            ),
          ),
        ],
      ),
    );
  }
}
