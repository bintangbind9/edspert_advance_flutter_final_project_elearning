import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/general_values.dart';
import '../../../domain/entities/user_model/user_model.dart';
import '../../../domain/entities/user_model/user_model_req.dart';
import '../../../domain/usecases/upload_file_usecase.dart';
import '../../bloc/images/images_bloc.dart';
import '../../bloc/storage/storage_bloc.dart';
import '../../bloc/user/user_bloc.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final fullNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final genderTextController = TextEditingController();
  final schoolGradeTextController = TextEditingController();
  final schoolNameTextController = TextEditingController();

  late UserModelReq _req;

  @override
  void initState() {
    fullNameTextController.text = widget.userModel.userName ?? '';
    emailTextController.text = widget.userModel.userEmail ?? '';
    genderTextController.text = widget.userModel.userGender ?? '';
    schoolGradeTextController.text = widget.userModel.kelas ?? '';
    schoolNameTextController.text = widget.userModel.userAsalSekolah ?? '';

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

  updateUser(UserModelReq req) {
    context.read<UserBloc>().add(UpdateUserEvent(req: req));
  }

  getUserAppEvent() {
    context
        .read<UserBloc>()
        .add(GetUserAppEvent(email: FirebaseAuth.instance.currentUser!.email!));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<StorageBloc, StorageState>(
          listenWhen: (previous, current) =>
              (previous is StorageInitial && current is UploadFileLoading) ||
              (previous is UploadFileLoading && current is UploadFileSuccess) ||
              (previous is UploadFileLoading && current is UploadFileError),
          listener: (context, state) {
            if (state is UploadFileSuccess) {
              UserModelReq req = _req;
              req.foto = state.downloadUrl;

              setState(() {
                _req = req;
              });

              updateUser(_req);
            }

            if (state is UploadFileError) {
              Fluttertoast.showToast(msg: state.message);
            }
          },
        ),
        BlocListener<UserBloc, UserState>(
          listenWhen: (previous, current) =>
              (previous is UpdateUserLoading && current is UpdateUserSuccess) ||
              (previous is UpdateUserLoading &&
                  current is UpdateUserApiError) ||
              (previous is UpdateUserLoading &&
                  current is UpdateUserInternalError),
          listener: (context, state) {
            if (state is UpdateUserSuccess) {
              Fluttertoast.showToast(msg: 'Berhasil Perbarui Data');
              getUserAppEvent();
            }
            if (state is UpdateUserApiError) {
              Fluttertoast.showToast(msg: state.message);
            }
            if (state is UpdateUserInternalError) {
              Fluttertoast.showToast(msg: state.message);
            }
          },
        ),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: Scaffold(
          appBar: buildAppBar(context),
          body: BlocBuilder<UserBloc, UserState>(
            buildWhen: (previous, current) =>
                (previous is UserInitial && current is UpdateUserLoading) ||
                (previous is UpdateUserLoading &&
                    current is UpdateUserSuccess) ||
                (previous is UpdateUserLoading &&
                    current is UpdateUserApiError) ||
                (previous is UpdateUserLoading &&
                    current is UpdateUserInternalError),
            builder: (context, state) {
              if (state is UpdateUserLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return BlocBuilder<StorageBloc, StorageState>(
                buildWhen: (previous, current) =>
                    (previous is StorageInitial &&
                        current is UploadFileLoading) ||
                    (previous is UploadFileLoading &&
                        current is UploadFileSuccess) ||
                    (previous is UploadFileLoading &&
                        current is UploadFileError),
                builder: (context, state) {
                  if (state is UploadFileLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return buildBody(context);
                },
              );
            },
          ),
        ),
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

    return Form(
      key: _formKey,
      child: ListView(
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
          TextFormField(
            controller: fullNameTextController,
            decoration: InputDecoration(
              labelText: 'Nama Lengkap',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
                FormBuilderValidators.minLength(6),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            readOnly: true,
            controller: emailTextController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.email(),
            ]),
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
            onTap: () async {
              String? gender = await showModalBottomSheet<String>(
                context: context,
                builder: (context) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text(GeneralValues.genderM),
                          trailing: const Icon(Icons.male),
                          onTap: () =>
                              Navigator.of(context).pop(GeneralValues.genderM),
                        ),
                        ListTile(
                          title: const Text(GeneralValues.genderF),
                          trailing: const Icon(Icons.female),
                          onTap: () =>
                              Navigator.of(context).pop(GeneralValues.genderF),
                        ),
                      ],
                    ),
                  );
                },
              );

              if (gender != null) {
                genderTextController.text = gender;
              }
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextField(
            readOnly: true,
            controller: schoolGradeTextController,
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.arrow_drop_down),
              labelText: 'Kelas',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onTap: () async {
              String? schoolGrade = await showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: GeneralValues.schoolGrades.length,
                    itemBuilder: (context, index) {
                      String grade = GeneralValues.schoolGrades[index];
                      return ListTile(
                        title: Text('Kelas $grade'),
                        onTap: () => Navigator.of(context).pop(grade),
                        trailing: const Icon(Icons.class_outlined),
                      );
                    },
                  );
                },
              );

              if (schoolGrade != null) {
                schoolGradeTextController.text = schoolGrade;
              }
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: schoolNameTextController,
            decoration: InputDecoration(
              labelText: 'Sekolah',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(6),
            ]),
          ),
          const SizedBox(height: 26),
          BlocBuilder<ImagesBloc, ImagesState>(
            buildWhen: (previous, current) =>
                (previous is ImagesInitial && current is ImagesDone),
            builder: (context, state) {
              return CommonButton(
                onPressed: () async {
                  if (genderTextController.text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: 'Jenis Kelamin belum dipilih!',
                      gravity: ToastGravity.TOP,
                      backgroundColor: AppColors.error,
                    );
                    return;
                  }

                  if (schoolGradeTextController.text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: 'Kelas belum dipilih!',
                      gravity: ToastGravity.TOP,
                      backgroundColor: AppColors.error,
                    );
                    return;
                  }

                  if (!_formKey.currentState!.validate()) return;

                  setState(() {
                    _req = UserModelReq(
                      namaLengkap: fullNameTextController.text,
                      email: emailTextController.text,
                      namaSekolah: schoolNameTextController.text,
                      kelas: schoolGradeTextController.text,
                      gender: genderTextController.text,
                      jenjang: GeneralValues.defaultJenjang,
                      foto: widget.userModel.userFoto,
                    );
                  });

                  if (state is ImagesDone && state.files.isNotEmpty) {
                    final String fileExt = state.files[0].path.split('.').last;
                    final String fileName =
                        '${DateTime.now().millisecondsSinceEpoch}.$fileExt';

                    context.read<StorageBloc>().add(
                          UploadFileEvent(
                            params: UploadFileParams(
                              fileName: fileName,
                              fileByte: await state.files[0].readAsBytes(),
                              storagePath: StoragePath.profilePict,
                            ),
                          ),
                        );
                  } else {
                    updateUser(_req);
                  }
                },
                text: 'Perbarui Data',
              );
            },
          ),
        ],
      ),
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
