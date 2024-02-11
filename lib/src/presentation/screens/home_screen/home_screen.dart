import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/general_values.dart';
import '../../bloc/banners/banners_bloc.dart';
import '../../bloc/courses/courses_bloc.dart';
import '../../bloc/user/user_bloc.dart';
import '../../widgets/profile_image_widget.dart';
import 'banner_list_home_screen.dart';
import 'course_list_home_screen.dart';
import 'top_banner_home_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
                majorName: GeneralValues.majorName,
                email: FirebaseAuth.instance.currentUser?.email ?? '',
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
        title: BlocBuilder<UserBloc, UserState>(
          buildWhen: (previous, current) =>
              (previous is GetUserAppLoading && current is GetUserAppSuccess),
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hai, ${state is GetUserAppSuccess ? (state.userModel.userName ?? 'Anonymous') : 'Anonymous'}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Selamat Datang',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                ProfileImageWidget(
                  diameter: 40,
                  isFromFile: false,
                  path: state is GetUserAppSuccess
                      ? (state.userModel.userFoto ?? '')
                      : '',
                  foregroundColor: AppColors.grayscaleOffWhite,
                  backgroundColor: AppColors.primary,
                ),
              ],
            );
          },
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
