import 'package:edspert_advance_flutter_final_project_elearning/common/constants/app_colors.dart';
import 'package:edspert_advance_flutter_final_project_elearning/common/constants/asset_images.dart';
import 'package:edspert_advance_flutter_final_project_elearning/presentation/auth/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) =>
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Image.asset(AssetImages.imgEdspertLogoWhitePng),
      ),
    );
  }
}
