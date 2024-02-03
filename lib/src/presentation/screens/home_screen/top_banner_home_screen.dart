import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/asset_images.dart';
import '../../../common/constants/styles.dart';

class TopBannerHomeScreen extends StatelessWidget {
  const TopBannerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Styles.mainPadding),
      height: 160,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(Styles.mainBorderRadius),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(Styles.mainPadding),
              alignment: Alignment.topLeft,
              child: const Text(
                'Mau kerjain latihan soal apa hari ini?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.grayscaleOffWhite,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset(
                AssetImages.imgTopBannerSvg,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
