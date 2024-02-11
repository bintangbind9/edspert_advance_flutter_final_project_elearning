import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/constants/app_colors.dart';
import '../../common/constants/asset_images.dart';
import '../bloc/base_screen_index/base_screen_index_bloc.dart';
import 'discussions/groups_screen.dart';
import 'home_screen/home_screen.dart';
import 'profile_screen/profile_screen.dart';

class BaseScreen extends StatefulWidget {
  final int screenIndex;

  const BaseScreen({
    super.key,
    required this.screenIndex,
  });

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BaseScreenIndexBloc>().add(
            BaseScreenIndexEventChange(
              index: widget.screenIndex,
            ),
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> baseScreen = [
      const HomeScreen(),
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
                builder: (context) => const GroupsScreen(),
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
