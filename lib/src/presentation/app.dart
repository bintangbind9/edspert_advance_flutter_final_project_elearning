import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/constants/app_colors.dart';
import '../data/firebase/firebase_service.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../data/repositories/banner_repository_impl.dart';
import '../data/repositories/course_repository_impl.dart';
import '../data/repositories/exercise_repository_impl.dart';
import '../data/repositories/user_repository_impl.dart';
import '../domain/usecases/get_banners_usecase.dart';
import '../domain/usecases/get_courses_usecase.dart';
import '../domain/usecases/get_exercises_usecase.dart';
import '../domain/usecases/get_questions_usecase.dart';
import '../domain/usecases/get_user_by_email_usecase.dart';
import '../domain/usecases/register_user_usecase.dart';
import '../domain/usecases/sign_in_google_usecase.dart';
import 'bloc/auth/auth_bloc.dart';
import 'bloc/banners/banners_bloc.dart';
import 'bloc/base_screen_index/base_screen_index_bloc.dart';
import 'bloc/courses/courses_bloc.dart';
import 'bloc/exercises/exercises_bloc.dart';
import 'bloc/questions/questions_bloc.dart';
import 'bloc/user/user_bloc.dart';
import 'screens/auth_screen/login_screen.dart';
import 'screens/auth_screen/register_screen.dart';
import 'screens/base_screen.dart';
import 'screens/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BaseScreenIndexBloc(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            signInWithGoogleUsecase: SignInWithGoogleUsecase(
              repository: AuthRepositoryImpl(
                firebaseService: FirebaseService(),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => CoursesBloc(
            getCoursesUsecase:
                GetCoursesUsecase(repository: CourseRepositoryImpl()),
          ),
        ),
        BlocProvider(
          create: (context) => BannersBloc(
            getBannersUsecase:
                GetBannersUsecase(repository: BannerRepositoryImpl()),
          ),
        ),
        BlocProvider(
          create: (context) => ExercisesBloc(
            getExercisesUsecase:
                GetExercisesUsecase(repository: ExerciseRepositoryImpl()),
          ),
        ),
        BlocProvider(
          create: (context) => UserBloc(
            registerUserUsecase: RegisterUserUsecase(
              repository: UserRepositoryImpl(),
            ),
            getUserByEmailUsecase: GetUserByEmailUsecase(
              repository: UserRepositoryImpl(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => QuestionsBloc(
            getQuestionsUsecase: GetQuestionsUsecase(
              repository: CourseRepositoryImpl(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'E-Learning',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: AppColors.grayscaleBackground,
        ),
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        home: FirebaseAuth.instance.currentUser == null
            ? const LoginScreen()
            : BlocBuilder<UserBloc, UserState>(
                buildWhen: (previous, current) =>
                    (previous is GetUserAppLoading &&
                        current is GetUserAppSuccess) ||
                    (previous is GetUserAppLoading &&
                        current is GetUserAppApiError),
                builder: (context, state) {
                  if (state is GetUserAppSuccess) {
                    return const BaseScreen();
                  } else if (state is GetUserAppApiError) {
                    return RegisterScreen(
                        email: FirebaseAuth.instance.currentUser!.email!);
                  } else {
                    return const SplashScreen();
                  }
                },
              ),
      ),
    );
  }
}
