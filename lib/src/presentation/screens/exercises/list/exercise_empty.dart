import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/asset_images.dart';

class ExerciseEmpty extends StatelessWidget {
  const ExerciseEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AssetImages.imgNoPackageSvg),
          SizedBox(
            width: MediaQuery.of(context).size.width * .8,
            child: const Text(
              'Yah, Paket tidak tersedia',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width * .8,
            child: const Text(
              'Tenang, masih banyak yang bisa kamu pelajari. cari lagi yuk!',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: AppColors.disableText,
              ),
            ),
          )
        ],
      ),
    );
  }
}
