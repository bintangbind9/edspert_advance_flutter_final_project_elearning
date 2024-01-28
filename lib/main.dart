import 'package:edspert_advance_flutter_final_project_elearning/common/constants/app_colors.dart';
import 'package:edspert_advance_flutter_final_project_elearning/presentation/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Learning',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: AppColors.grayscaleBackground,
      ),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: const SplashScreen(),
    );
  }
}
