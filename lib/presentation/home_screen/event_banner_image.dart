import 'package:edspert_advance_flutter_final_project_elearning/common/constants/styles.dart';
import 'package:flutter/material.dart';

import '../../common/constants/asset_images.dart';
import '../../data/model/event_banner_model.dart';

class EventBannerImage extends StatelessWidget {
  final EventBanner banner;
  const EventBannerImage({
    super.key,
    required this.banner,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: Styles.mainPadding),
        ClipRRect(
          borderRadius: BorderRadius.circular(Styles.mainBorderRadius),
          child: Image.network(
            banner.eventImage ?? '',
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(AssetImages.imgNoImagePng);
            },
          ),
        ),
      ],
    );
  }
}
