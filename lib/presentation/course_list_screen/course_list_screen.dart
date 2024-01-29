import 'package:edspert_advance_flutter_final_project_elearning/common/constants/app_colors.dart';
import 'package:edspert_advance_flutter_final_project_elearning/common/constants/styles.dart';
import 'package:edspert_advance_flutter_final_project_elearning/presentation/widgets/course_tile.dart';
import 'package:flutter/material.dart';

import '../../data/model/course_model.dart';

class CourseListScreen extends StatelessWidget {
  final List<Course> courses;
  const CourseListScreen({
    super.key,
    required this.courses,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.grayscaleOffWhite,
        backgroundColor: AppColors.primary,
        centerTitle: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Pilih Pelajaran',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(Styles.mainPadding),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Course course = courses[index];
          return CourseTile(course: course);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: Styles.mainPadding);
        },
        itemCount: courses.length,
      ),
    );
  }
}
