import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/asset_images.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../widgets/social_login_button.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          (previous is SignInWithGoogleLoading &&
              current is SignInWithGoogleSuccess) ||
          (previous is SignInWithGoogleLoading &&
              current is SignInWithGoogleError),
      listener: (context, state) {
        if (state is SignInWithGoogleSuccess) {
          Fluttertoast.showToast(
            msg: "Signed in using ${state.email}",
            gravity: ToastGravity.TOP,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterScreen(
                email: state.email,
              ),
            ),
          );
        }

        if (state is SignInWithGoogleError) {
          Fluttertoast.showToast(
            msg: "Failed to sign in with Google",
            gravity: ToastGravity.TOP,
            backgroundColor: AppColors.error,
          );
        }
      },
      child: Scaffold(
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
            child: ListView(
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
                const SizedBox(height: 120),
                Column(
                  children: [
                    SocialLoginButton(
                      onPressed: () => _onGoogleSignInPressed(context),
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      logo: AssetImages.iconGooglePng,
                      text: 'Masuk dengan Google',
                    ),
                    const SizedBox(height: 12),
                    SocialLoginButton(
                      onPressed: () {
                        Fluttertoast.showToast(
                          msg: 'Sign in with Apple ID is coming soon.',
                          gravity: ToastGravity.TOP,
                        );
                      },
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
      ),
    );
  }

  void _onGoogleSignInPressed(BuildContext context) {
    context.read<AuthBloc>().add(SignInWithGoogleEvent());
  }
}
