import 'package:edspert_advance_flutter_final_project_elearning/business_logic/banners/banners_bloc.dart';
import 'package:edspert_advance_flutter_final_project_elearning/business_logic/courses/courses_bloc.dart';
import 'package:edspert_advance_flutter_final_project_elearning/common/constants/app_colors.dart';
import 'package:edspert_advance_flutter_final_project_elearning/common/constants/asset_images.dart';
import 'package:edspert_advance_flutter_final_project_elearning/common/constants/general_values.dart';
import 'package:edspert_advance_flutter_final_project_elearning/common/constants/styles.dart';
import 'package:edspert_advance_flutter_final_project_elearning/data/model/course_model.dart';
import 'package:edspert_advance_flutter_final_project_elearning/presentation/home_screen/top_banner.dart';
import 'package:edspert_advance_flutter_final_project_elearning/presentation/widgets/sub_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              SubSection(
                title: 'Pilih Pelajaran',
                trailing: TextButton(
                  onPressed: () {},
                  child: const Text('Lihat Semua'),
                ),
                horizontalTitlePadding: Styles.mainPadding,
                verticalTitlePadding: Styles.mainPadding / 2,
                horizontalChildPadding: Styles.mainPadding,
                child: BlocBuilder<CoursesBloc, CoursesState>(
                  builder: (context, state) {
                    if (state is CoursesError) {
                      return Text(state.message);
                    } else if (state is CoursesSuccess) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: GeneralValues.maxHomeCourseCount,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          Course course = state.courses[index];
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        course.courseName ?? 'No Name',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '//${course.jumlahDone}/${course.jumlahMateri} Paket latihan soal',
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
                                      color: AppColors
                                          .grayscaleCourseImgBackground,
                                    ),
                                    child: Image.network(
                                      course.urlCover!,
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          AssetImages.imgNoImagePng,
                                        );
                                      },
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }

                    return const CircularProgressIndicator();
                  },
                ),
              ),
              SubSection(
                title: 'Terbaru',
                horizontalTitlePadding: Styles.mainPadding,
                verticalTitlePadding: Styles.mainPadding,
                child: BlocBuilder<BannersBloc, BannersState>(
                  builder: (context, state) {
                    if (state is BannersError) {
                      return Text(state.message);
                    } else if (state is BannersSuccess) {
                      return SizedBox(
                        height: 160,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.banners.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final banner = state.banners[index];
                            return Row(
                              children: [
                                const SizedBox(width: Styles.mainPadding),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      Styles.mainBorderRadius),
                                  child: Image.network(
                                    banner.eventImage ?? '',
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                          AssetImages.imgNoImagePng);
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    }

                    return const CircularProgressIndicator();
                  },
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
