import 'package:edspert_advance_flutter_final_project_elearning/business_logic/base_screen_index/base_screen_index_bloc.dart';
import 'package:edspert_advance_flutter_final_project_elearning/common/constants/app_colors.dart';
import 'package:edspert_advance_flutter_final_project_elearning/common/constants/asset_images.dart';
import 'package:edspert_advance_flutter_final_project_elearning/common/constants/general_values.dart';
import 'package:edspert_advance_flutter_final_project_elearning/presentation/discussion_screen.dart';
import 'package:edspert_advance_flutter_final_project_elearning/presentation/home_screen/home_screen.dart';
import 'package:edspert_advance_flutter_final_project_elearning/presentation/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> baseScreen = [
      const HomeScreen(
        majorName: GeneralValues.majorName,
        email: GeneralValues.testingEmail,
      ),
      const ProfileScreen(),
    ];

    return BlocProvider(
      create: (context) => BaseScreenIndexBloc(),
      child: BlocBuilder<BaseScreenIndexBloc, int>(
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
                  activeIcon:
                      SvgPicture.asset(AssetImages.iconPersonEnabledSvg),
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
      ),
    );
  }
}
