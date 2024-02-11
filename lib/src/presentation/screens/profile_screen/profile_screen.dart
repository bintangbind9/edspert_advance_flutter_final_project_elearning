import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/styles.dart';
import '../../../common/utils/generic_dialog.dart';
import '../../../domain/entities/user_model/user_model.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/user/user_bloc.dart';
import '../../widgets/common_button.dart';
import '../../widgets/profile_image_widget.dart';
import 'profile_edit_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double appBarHeight = 100;

    signOut() {
      context.read<AuthBloc>().add(SignOutEvent());
    }

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          (previous is SignOutLoading && current is SignOutSuccess) ||
          (previous is SignOutLoading && current is SignOutError),
      listener: (context, state) {
        context.read<AuthBloc>().add(IsUserSignedInEvent());
      },
      child: BlocBuilder<UserBloc, UserState>(
        buildWhen: (previous, current) =>
            (previous is GetUserAppLoading && current is GetUserAppSuccess) ||
            (previous is GetUserAppLoading && current is GetUserAppApiError) ||
            (previous is GetUserAppLoading &&
                current is GetUserAppInternalError),
        builder: (context, state) {
          if (state is GetUserAppSuccess) {
            return Scaffold(
              appBar: buildAppBarProfileScreen(
                context,
                appBarHeight,
                state.userModel,
              ),
              body: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 18,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 18,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.grayscaleOffWhite,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 0),
                          blurRadius: 7,
                          spreadRadius: 0,
                          color: Colors.black.withOpacity(0.25),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Identitas Diri',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 32),
                        buildContentProfile(
                          context: context,
                          title: 'Nama Lengkap',
                          value: state.userModel.userName ?? '',
                        ),
                        buildContentProfile(
                          context: context,
                          title: 'Email',
                          value: state.userModel.userEmail ?? '',
                        ),
                        buildContentProfile(
                          context: context,
                          title: 'Jenis Kelamin',
                          value: state.userModel.userGender ?? '',
                        ),
                        buildContentProfile(
                          context: context,
                          title: 'Kelas',
                          value: state.userModel.kelas ?? '',
                        ),
                        buildContentProfile(
                          context: context,
                          title: 'Sekolah',
                          value: state.userModel.userAsalSekolah ?? '',
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                  buildLogoutSection(
                    context: context,
                    onTap: () async {
                      bool? isLogout = await showGenericDialog<bool>(
                        context,
                        'Kamu Yakin ingin Keluar?',
                        [
                          CommonButton(
                            text: 'Tidak',
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                          CommonButton(
                            text: 'Ya',
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            backgroundColor: Colors.transparent,
                            textColor: AppColors.primary,
                          ),
                        ],
                      );

                      isLogout = isLogout ?? false;

                      if (isLogout) {
                        signOut();
                      }
                    },
                  ),
                ],
              ),
            );
          }

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  AppBar buildAppBarProfileScreen(
    BuildContext context,
    double appBarHeight,
    UserModel userModel,
  ) {
    return AppBar(
      title: const Text('Akun Saya'),
      foregroundColor: AppColors.grayscaleOffWhite,
      backgroundColor: AppColors.primary,
      centerTitle: true,
      actions: [
        TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileEditScreen(
                userModel: userModel,
              ),
            ),
          ),
          child: const Text(
            'Edit',
            style: TextStyle(
              color: AppColors.grayscaleOffWhite,
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight),
        child: SizedBox(
          height: appBarHeight,
          child: Padding(
            padding: const EdgeInsets.all(Styles.mainPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userModel.userName!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.grayscaleOffWhite,
                      ),
                    ),
                    Text(
                      userModel.userAsalSekolah!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.grayscaleOffWhite,
                      ),
                    ),
                  ],
                ),
                ProfileImageWidget(
                  diameter: 40,
                  isFromFile: false,
                  path: userModel.userFoto ?? '',
                  foregroundColor: AppColors.primary,
                  backgroundColor: AppColors.grayscaleOffWhite,
                ),
              ],
            ),
          ),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(Styles.mainBorderRadius / 2),
          bottomRight: Radius.circular(Styles.mainBorderRadius / 2),
        ),
      ),
    );
  }

  Widget buildContentProfile({
    required BuildContext context,
    required String title,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.disableText,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16)
      ],
    );
  }

  Widget buildLogoutSection({
    required BuildContext context,
    required GestureTapCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: 18,
        ),
        decoration: BoxDecoration(
          color: AppColors.grayscaleOffWhite,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 6,
              spreadRadius: 0,
              offset: const Offset(0, 0),
            )
          ],
        ),
        child: const Row(
          children: [
            Icon(
              Icons.exit_to_app,
              color: AppColors.error,
            ),
            SizedBox(width: 6),
            Text(
              'Keluar',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
