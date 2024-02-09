import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/asset_images.dart';
import '../../../../common/constants/general_values.dart';
import '../../../../domain/entities/exercises/submit_exercise_answers_req.dart';
import '../../../../domain/entities/question_model/question_answer_model.dart';
import '../../../bloc/exercises/exercises_bloc.dart';
import '../../../bloc/question_answer/question_answer_bloc.dart';
import '../../../bloc/question_index/question_index_bloc.dart';
import '../../../widgets/common_button.dart';

class BottomButtonWidget extends StatelessWidget {
  final String exerciseId;
  final int questionIndex;
  final int questionsCount;

  const BottomButtonWidget({
    super.key,
    required this.exerciseId,
    required this.questionIndex,
    required this.questionsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (questionIndex > 0)
          CommonButton(
            text: 'Sebelumnya',
            onPressed: () {
              if (questionIndex > 0) {
                context
                    .read<QuestionIndexBloc>()
                    .add(SetQuestionIndexEvent(index: questionIndex - 1));
              }
            },
          )
        else
          const SizedBox(),
        Builder(
          builder: (context) {
            final questionAnswerState =
                context.watch<QuestionAnswerBloc>().state;
            final exercisesState = context.watch<ExercisesBloc>().state;

            return CommonButton(
              text: questionIndex < questionsCount - 1
                  ? 'Selanjutnya'
                  : (exercisesState is SubmitExerciseLoading
                      ? 'Mengirim...'
                      : 'Kumpulin'),
              onPressed: () {
                if (questionIndex < questionsCount - 1) {
                  context
                      .read<QuestionIndexBloc>()
                      .add(SetQuestionIndexEvent(index: questionIndex + 1));
                } else {
                  if (questionAnswerState is SetQuestionAnswerSuccess) {
                    if (questionAnswerState.questionAnswers.any(
                      (e) => e.answer == GeneralValues.defaultAnswer,
                    )) {
                      Fluttertoast.showToast(
                        msg:
                            'Oops! Soal belum dikerjakan semua. Periksa kembali jawaban Kamu!',
                      );
                    } else {
                      if (exercisesState is! SubmitExerciseLoading) {
                        showModalSubmitExercise(
                          context,
                          exerciseId,
                          questionAnswerState.questionAnswers,
                        );
                      }
                    }
                  }
                }
              },
            );
          },
        ),
      ],
    );
  }

  void showModalSubmitExercise(BuildContext context, String exerciseId,
      List<QuestionAnswer> questionAnswers) {
    double modalHeight = 340;
    double minSpacer = 20;
    double maxSpacer = 40;
    double buttonMinWidth = 120;
    double buttonMaxWidth = 200;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: modalHeight,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                height: 8,
                width: 100,
                decoration: BoxDecoration(
                  color: AppColors.disable,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              SizedBox(height: minSpacer),
              SvgPicture.asset(
                AssetImages.imgSubmitExerciseSvg,
              ),
              SizedBox(height: minSpacer),
              const Text(
                'Kumpulkan latihan soal sekarang?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Boleh langsung kumpulin dong',
                style: TextStyle(
                  color: AppColors.disableText,
                ),
              ),
              SizedBox(height: maxSpacer),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: buttonMinWidth,
                      maxWidth: buttonMaxWidth,
                    ),
                    child: CommonButton(
                      text: 'Nanti dulu',
                      textColor: AppColors.primary,
                      backgroundColor: Colors.transparent,
                      borderColor: AppColors.primary,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: buttonMinWidth,
                      maxWidth: buttonMaxWidth,
                    ),
                    child: CommonButton(
                      text: 'Ya',
                      onPressed: () {
                        context.read<ExercisesBloc>().add(
                              SubmitExerciseEvent(
                                req: SubmitExerciseAnswersReq(
                                  userEmail:
                                      FirebaseAuth.instance.currentUser!.email!,
                                  exerciseId: exerciseId,
                                  bankQuestionIds: List<String>.from(
                                      questionAnswers.map((e) => e.questionId)),
                                  studentAnswers: List<String>.from(
                                      questionAnswers.map((e) => e.answer)),
                                ),
                              ),
                            );
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
