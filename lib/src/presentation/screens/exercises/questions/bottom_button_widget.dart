import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../common/constants/general_values.dart';
import '../../../bloc/bloc/question_answer_bloc.dart';
import '../../../bloc/question_index/question_index_bloc.dart';
import '../../../widgets/common_button.dart';

class BottomButtonWidget extends StatelessWidget {
  final int questionIndex;
  final int questionsCount;

  const BottomButtonWidget({
    super.key,
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
        BlocBuilder<QuestionAnswerBloc, QuestionAnswerState>(
          builder: (context, state) {
            return CommonButton(
              text: questionIndex < questionsCount - 1
                  ? 'Selanjutnya'
                  : 'Kumpulin',
              onPressed: () {
                if (questionIndex < questionsCount - 1) {
                  context
                      .read<QuestionIndexBloc>()
                      .add(SetQuestionIndexEvent(index: questionIndex + 1));
                } else {
                  if (state is SetQuestionAnswerSuccess) {
                    if (state.questionAnswers.any(
                      (e) => e.answer == GeneralValues.defaultAnswer,
                    )) {
                      Fluttertoast.showToast(
                        msg:
                            'Oops! Soal belum dikerjakan semua. Periksa kembali jawaban Kamu!',
                      );
                    } else {
                      Fluttertoast.showToast(msg: 'Kumpulin');
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
}
