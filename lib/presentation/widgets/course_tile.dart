import 'package:edspert_advance_flutter_final_project_elearning/common/constants/general_values.dart';
import 'package:edspert_advance_flutter_final_project_elearning/data/model/course_model.dart';
import 'package:edspert_advance_flutter_final_project_elearning/presentation/exercise_list_screen/exercise_list_screen.dart';
import 'package:flutter/material.dart';

import '../../common/constants/app_colors.dart';
import '../../common/constants/asset_images.dart';

class CourseTile extends StatelessWidget {
  final Course course;

  const CourseTile({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    String courseCategory = course.courseCategory ?? 'soal';
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.courseName ?? 'No Name',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${course.jumlahDone}/${course.jumlahMateri} Paket ${courseCategory.replaceAll('_', ' ')}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.disableText,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
            subtitle: LinearProgressIndicator(
              value: course.progress!.toDouble(),
            ),
            leading: Container(
              width: 55,
              height: 55,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.grayscaleCourseImgBackground,
              ),
              child: Image.network(
                course.urlCover!,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    AssetImages.imgNoImagePng,
                  );
                },
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseListScreen(
                    courseId: course.courseId,
                    courseName: course.courseName ?? 'No Name',
                    email: GeneralValues.testingEmail,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
