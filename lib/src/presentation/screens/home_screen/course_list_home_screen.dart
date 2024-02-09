import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constants/general_values.dart';
import '../../../common/constants/styles.dart';
import '../../../domain/entities/course_model.dart';
import '../../bloc/courses/courses_bloc.dart';
import '../../widgets/course_tile.dart';
import '../../widgets/sub_section.dart';
import '../course_list_screen/course_list_screen.dart';

class CourseListHomeScreen extends StatelessWidget {
  const CourseListHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesBloc, CoursesState>(
      buildWhen: (previous, current) =>
          (previous is GetCoursesLoading && current is GetCoursesSuccess) ||
          (previous is GetCoursesLoading && current is GetCoursesError),
      builder: (context, state) {
        return SubSection(
          title: 'Pilih Pelajaran',
          trailing: TextButton(
            onPressed: () {
              if (state is GetCoursesSuccess) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CourseListScreen(courses: state.courses),
                  ),
                );
              }
            },
            child: const Text('Lihat Semua'),
          ),
          horizontalTitlePadding: Styles.mainPadding,
          verticalTitlePadding: Styles.mainPadding / 2,
          child: state is GetCoursesError
              ? Text(state.message)
              : (state is GetCoursesSuccess
                  ? ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Styles.mainPadding,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: GeneralValues.maxHomeCourseCount,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        Course course = state.courses[index];
                        return CourseTile(course: course);
                      },
                    )
                  : const CircularProgressIndicator()),
        );
      },
    );
  }
}
