import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../common/constants/app_colors.dart';
import '../../common/constants/asset_images.dart';
import '../bloc/user/user_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<UserBloc>().add(
          GetUserAppEvent(email: FirebaseAuth.instance.currentUser!.email!));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listenWhen: (previous, current) =>
          (previous is GetUserAppLoading && current is GetUserAppInternalError),
      listener: (context, state) {
        if (state is GetUserAppInternalError) {
          Fluttertoast.showToast(
            msg: state.message,
            gravity: ToastGravity.TOP,
            backgroundColor: AppColors.error,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: Image.asset(AssetImages.imgEdspertLogoWhitePng),
        ),
      ),
    );
  }
}
