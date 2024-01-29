import 'package:edspert_advance_flutter_final_project_elearning/business_logic/banners/banners_bloc.dart';
import 'package:edspert_advance_flutter_final_project_elearning/business_logic/courses/courses_bloc.dart';
import 'package:edspert_advance_flutter_final_project_elearning/common/constants/asset_images.dart';
import 'package:edspert_advance_flutter_final_project_elearning/common/constants/general_values.dart';
import 'package:edspert_advance_flutter_final_project_elearning/common/constants/styles.dart';
import 'package:edspert_advance_flutter_final_project_elearning/data/model/course_model.dart';
import 'package:edspert_advance_flutter_final_project_elearning/presentation/course_list_screen/course_list_screen.dart';
import 'package:edspert_advance_flutter_final_project_elearning/presentation/home_screen/event_banner_image.dart';
import 'package:edspert_advance_flutter_final_project_elearning/presentation/home_screen/top_banner.dart';
import 'package:edspert_advance_flutter_final_project_elearning/presentation/widgets/course_tile.dart';
import 'package:edspert_advance_flutter_final_project_elearning/presentation/widgets/sub_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/event_banner_model.dart';

class HomeScreen extends StatelessWidget {
  final String majorName;
  final String email;
  const HomeScreen({
    super.key,
    required this.majorName,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CoursesBloc()
            ..add(GetCoursesEvent(majorName: majorName, email: email)),
        ),
        BlocProvider(
          create: (context) => BannersBloc()
            ..add(GetBannersEvent(limit: GeneralValues.maxHomeBannerCount)),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hai, Bintang',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Selamat Datang',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                child: Image.asset(AssetImages.imgProfilePictPng),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const TopBanner(),
              BlocBuilder<CoursesBloc, CoursesState>(
                builder: (context, state) {
                  return SubSection(
                    title: 'Pilih Pelajaran',
                    trailing: TextButton(
                      onPressed: () {
                        if (state is CoursesSuccess) {
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
                    child: state is CoursesError
                        ? Text(state.message)
                        : (state is CoursesSuccess
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
              ),
              BlocBuilder<BannersBloc, BannersState>(
                builder: (context, state) {
                  return SubSection(
                    title: 'Terbaru',
                    horizontalTitlePadding: Styles.mainPadding,
                    verticalTitlePadding: Styles.mainPadding,
                    child: state is BannersError
                        ? Text(state.message)
                        : (state is BannersSuccess
                            ? SizedBox(
                                height: 160,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.banners.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final EventBanner banner =
                                        state.banners[index];
                                    return EventBannerImage(banner: banner);
                                  },
                                ),
                              )
                            : const CircularProgressIndicator()),
                  );
                },
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
