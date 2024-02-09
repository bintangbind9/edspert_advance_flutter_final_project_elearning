import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/asset_images.dart';
import '../../../../domain/entities/exercises/exercise_result.dart';

class ExerciseResultScreen extends StatelessWidget {
  final ExerciseResult exerciseResult;

  const ExerciseResultScreen({
    super.key,
    required this.exerciseResult,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.grayscaleOffWhite,
                  ),
                ),
                const Text(
                  'Tutup',
                  style: TextStyle(color: AppColors.grayscaleOffWhite),
                ),
              ],
            ),
            const Text(
              'Selamat',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: AppColors.grayscaleOffWhite,
              ),
            ),
            const Text(
              'Kamu telah menyelesaikan Kuiz ini',
              style: TextStyle(
                color: AppColors.grayscaleOffWhite,
              ),
            ),
            const SizedBox(height: 40),
            SvgPicture.asset(AssetImages.imgChampionSvg),
            const SizedBox(height: 40),
            const Text(
              'Nilai Kamu:',
              style: TextStyle(
                color: AppColors.grayscaleOffWhite,
              ),
            ),
            Text(
              '${exerciseResult.result!.jumlahScore}',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 100,
                color: AppColors.grayscaleOffWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
