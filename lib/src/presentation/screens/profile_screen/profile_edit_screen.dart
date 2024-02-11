import 'package:flutter/material.dart';

import '../../../common/constants/app_colors.dart';
import '../../../domain/entities/user_model/user_model.dart';
import '../../widgets/common_button.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final fullNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final genderTextController = TextEditingController();
  final schoolGradeTextController = TextEditingController();
  final schoolNameTextController = TextEditingController();

  @override
  void dispose() {
    fullNameTextController.dispose();
    emailTextController.dispose();
    genderTextController.dispose();
    schoolGradeTextController.dispose();
    schoolNameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        appBar: buildAppBar(context),
        body: buildBody(context),
      ),
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.chevron_left),
      ),
      title: const Text('Edit Akun'),
      centerTitle: true,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.grayscaleOffWhite,
    );
  }

  Widget buildBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 26,
      ),
      children: [
        const Text(
          'Data Diri',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          controller: fullNameTextController,
          decoration: InputDecoration(
            labelText: 'Nama Lengkap',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          readOnly: true,
          controller: emailTextController,
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          readOnly: true,
          controller: genderTextController,
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.arrow_drop_down),
            labelText: 'Jenis Kelamin',
            hintText: 'Pilih Jenis Kelamin',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onTap: () {},
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          controller: schoolGradeTextController,
          decoration: InputDecoration(
            labelText: 'Kelas',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          controller: schoolNameTextController,
          decoration: InputDecoration(
            labelText: 'Sekolah',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        const SizedBox(height: 26),
        CommonButton(
          onPressed: () {
            // return await controller.updateData(
            //   UserRegistrationRequest(
            //     fullName: controller.fullNameTextController.text,
            //     email: controller.emailTextController.text,
            //     gender: controller.etGender.text,
            //     schoolGrade: controller.schoolGradeTextController.text,
            //     schoolName: controller.schoolNameTextController.text,
            //     schoolLevel: GeneralValues.defaultJenjang,
            //     photoUrl: GeneralValues.defaultPhotoURL,
            //   ),
            // );
          },
          text: 'Perbarui Data',
        ),
      ],
    );
  }
}
