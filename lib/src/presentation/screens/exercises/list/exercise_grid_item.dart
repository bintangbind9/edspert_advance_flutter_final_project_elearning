import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/asset_images.dart';
import '../../../../common/constants/styles.dart';
import '../../../../domain/entities/exercises/exercise_model.dart';
import '../questions/exercise_questions_screen.dart';

class ExerciseGridItem extends StatelessWidget {
  final Exercise exercise;

  const ExerciseGridItem({
    super.key,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ExerciseQuestionsScreen(
            exercise: exercise,
            email: FirebaseAuth.instance.currentUser!.email!,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(Styles.mainPadding / 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Styles.mainBorderRadius,
          ),
          color: AppColors.grayscaleOffWhite,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.grayscaleCourseImgBackground,
                borderRadius: BorderRadius.circular(
                  Styles.mainBorderRadius / 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.network(
                  exercise.icon ?? '',
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    AssetImages.imgNoImagePng,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.exerciseTitle ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${exercise.jumlahDone}/${exercise.jumlahSoal} Soal',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
