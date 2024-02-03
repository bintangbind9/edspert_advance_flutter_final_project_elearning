import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/general_values.dart';
import '../../widgets/register_button.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  final String email;
  const RegisterScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _fullNameTextController = TextEditingController();
  final TextEditingController _schoolNameTextController =
      TextEditingController();
  String? selectedKelas;
  String jenisKelamin = '';

  bool isAllValid = false;

  @override
  void initState() {
    _emailTextController.text = widget.email;
    super.initState();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _fullNameTextController.dispose();
    _schoolNameTextController.dispose();
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
        appBar: AppBar(
          backgroundColor: AppColors.grayscaleOffWhite,
          leading: IconButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            ),
            color: Colors.black,
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text(
            'Yuk isi data diri',
            style: TextStyle(
              color: AppColors.grayscaleTitleActive,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          bottom: const PreferredSize(
            preferredSize: Size(double.infinity, 40),
            child: SizedBox.shrink(),
          ),
          shadowColor: AppColors.grayscaleLine,
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                'Email',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              TextFormField(
                controller: _emailTextController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                enabled: false,
              ),
              const SizedBox(height: 24),
              const Text(
                'Nama Lengkap',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              TextFormField(
                controller: _fullNameTextController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'contoh: Moh. Bintang Saputra',
                ),
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(6),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Jenis Kelamin',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          jenisKelamin = GeneralValues.genderM;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 35,
                        ),
                        decoration: BoxDecoration(
                          color: jenisKelamin == GeneralValues.genderM
                              ? Colors.green
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.grayscaleOutLine,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          GeneralValues.genderM,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: jenisKelamin == GeneralValues.genderM
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          jenisKelamin = GeneralValues.genderF;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 35,
                        ),
                        decoration: BoxDecoration(
                          color: jenisKelamin == GeneralValues.genderF
                              ? Colors.green
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.grayscaleOutLine,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          GeneralValues.genderF,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: jenisKelamin == GeneralValues.genderF
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text('Kelas',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Container(
                height: 56,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.grayscaleOutLine,
                      width: 1,
                    )),
                child: DropdownButton<String?>(
                  isExpanded: true,
                  value: selectedKelas,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  hint: const Text('Pilih Kelas'),
                  items: ['10', '11', '12']
                      .map((element) => DropdownMenuItem<String?>(
                          value: element, child: Text('Kelas $element')))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      if (value != null) {
                        selectedKelas = value;
                      }
                    });
                  },
                ),
              ),
              const SizedBox(height: 24),
              const Text('Nama Sekolah',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              TextFormField(
                controller: _schoolNameTextController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'Nama Sekolah',
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(6),
                ]),
              ),
              const SizedBox(
                height: 36,
              ),
              RegisterButton(
                text: 'DAFTAR',
                textColor: Colors.white,
                backgroundColor: AppColors.primary,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
