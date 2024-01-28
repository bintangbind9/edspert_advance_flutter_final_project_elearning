import 'package:edspert_advance_flutter_final_project_elearning/common/constants/asset_images.dart';
import 'package:edspert_advance_flutter_final_project_elearning/presentation/auth/register_screen.dart';
import 'package:edspert_advance_flutter_final_project_elearning/presentation/base_screen.dart';
import 'package:edspert_advance_flutter_final_project_elearning/presentation/widgets/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Login',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(AssetImages.imgIllustrationLoginSvg),
              const Column(
                children: [
                  Text(
                    'Selamat Datang',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Selamat Datang di Aplikasi Widya Edu Aplikasi Latihan dan Konsultasi Soal',
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              Column(
                children: [
                  SocialLoginButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BaseScreen(),
                      ),
                    ),
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    logo: AssetImages.iconGooglePng,
                    text: 'Masuk dengan Google',
                  ),
                  const SizedBox(height: 12),
                  SocialLoginButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    logo: AssetImages.iconApplePng,
                    text: 'Masuk dengan Apple ID',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
