import 'package:flutter/material.dart';

import '../../../common/constants/asset_images.dart';
import '../../../common/constants/styles.dart';
import '../../../domain/entities/event_banner_model.dart';

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
