import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/constants/app_colors.dart';
import '../../common/constants/asset_images.dart';
import '../../common/constants/general_values.dart';
import '../../domain/entities/user_model/user_model.dart';
import '../bloc/base_screen_index/base_screen_index_bloc.dart';
import '../bloc/user/user_bloc.dart';
import 'discussion_screen.dart';
import 'home_screen/home_screen.dart';
import 'profile_screen.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> baseScreen = [
      BlocBuilder<UserBloc, UserState>(
        buildWhen: (previous, current) =>
            (previous is GetUserAppLoading && current is GetUserAppSuccess),
        builder: (context, state) {
          return HomeScreen(
            majorName: GeneralValues.majorName,
            userModel:
                state is GetUserAppSuccess ? state.userModel : UserModel(),
          );
        },
      ),
      const ProfileScreen(),
    ];

    return BlocBuilder<BaseScreenIndexBloc, int>(
      builder: (context, indexScreen) {
        return Scaffold(
          body: baseScreen[indexScreen],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) => context
                .read<BaseScreenIndexBloc>()
                .add(BaseScreenIndexEventChange(index: value)),
            currentIndex: indexScreen,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AssetImages.iconHomeDisabledSvg),
                label: 'Home',
                activeIcon: SvgPicture.asset(AssetImages.iconHomeEnabledSvg),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AssetImages.iconPersonDisabledSvg),
                label: 'Profile',
                activeIcon: SvgPicture.asset(AssetImages.iconPersonEnabledSvg),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DiscussionScreen(),
              ),
            ),
            shape: const CircleBorder(),
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.grayscaleOffWhite,
            child: SvgPicture.asset(AssetImages.iconQuizSvg),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
