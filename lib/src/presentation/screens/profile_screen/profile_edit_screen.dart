import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/constants/app_colors.dart';
import '../../../domain/entities/user_model/user_model.dart';
import '../../bloc/images/images_bloc.dart';
import '../../widgets/common_button.dart';
import '../../widgets/profile_image_widget.dart';

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
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ImagesBloc>().add(SetImagesEvent(files: const []));
    });
    super.initState();
  }

  @override
  void dispose() {
    fullNameTextController.dispose();
    emailTextController.dispose();
    genderTextController.dispose();
    schoolGradeTextController.dispose();
    schoolNameTextController.dispose();
    super.dispose();
  }

  pickImage(ImageSource imageSource) {
    context.read<ImagesBloc>().add(PickImageEvent(imageSource: imageSource));
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
    double profilePictDiameter = 160;

    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 26,
      ),
      children: [
        SizedBox(
          child: Center(
            child: Stack(
              children: [
                BlocBuilder<ImagesBloc, ImagesState>(
                  buildWhen: (previous, current) =>
                      (previous is ImagesInitial && current is ImagesDone),
                  builder: (context, state) {
                    if (state is ImagesDone && state.files.isNotEmpty) {
                      return ProfileImageWidget(
                        diameter: profilePictDiameter,
                        isFromFile: true,
                        path: state.files[0].path,
                        foregroundColor: AppColors.grayscaleOffWhite,
                        backgroundColor: AppColors.primary,
                      );
                    } else {
                      return ProfileImageWidget(
                        diameter: profilePictDiameter,
                        isFromFile: false,
                        path: widget.userModel.userFoto ?? '',
                        foregroundColor: AppColors.grayscaleOffWhite,
                        backgroundColor: AppColors.primary,
                      );
                    }
                  },
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () async {
                      await updateImageProfile(context);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.grayscaleInputBackground,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset.zero,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: const Center(
                          child: Icon(
                        Icons.edit,
                        color: AppColors.primary,
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 26),
        const Text(
          'Data Diri',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 16),
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

  Future<void> updateImageProfile(BuildContext context) async {
    ImageSource? imageSource = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(
                  ImageSource.camera,
                ),
                child: const Row(
                  children: [
                    Icon(Icons.camera_alt),
                    SizedBox(width: 10),
                    Text('Camera'),
                  ],
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(
                  ImageSource.gallery,
                ),
                child: const Row(
                  children: [
                    Icon(Icons.image),
                    SizedBox(width: 10),
                    Text('Gallery'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );

    if (imageSource != null) {
      pickImage(imageSource);
    }
  }
}
