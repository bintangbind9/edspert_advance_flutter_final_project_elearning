import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constants/asset_images.dart';
import '../../../common/constants/general_values.dart';
import '../../../domain/entities/user_model/user_model.dart';
import '../../bloc/banners/banners_bloc.dart';
import '../../bloc/courses/courses_bloc.dart';
import 'banner_list_home_screen.dart';
import 'course_list_home_screen.dart';
import 'top_banner_home_screen.dart';

class HomeScreen extends StatefulWidget {
  final String majorName;
  final UserModel userModel;
  const HomeScreen({
    super.key,
    required this.majorName,
    required this.userModel,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        context.read<CoursesBloc>().add(
              GetCoursesEvent(
                majorName: widget.majorName,
                email: widget.userModel.userEmail!,
              ),
            );

        context.read<BannersBloc>().add(
              GetBannersEvent(
                limit: GeneralValues.maxHomeBannerCount,
              ),
            );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: const SingleChildScrollView(
        child: Column(
          children: [
            TopBannerHomeScreen(),
            CourseListHomeScreen(),
            BannerListHomeScreen(),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
