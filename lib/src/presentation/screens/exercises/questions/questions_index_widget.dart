import 'package:flutter/material.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../domain/entities/question_model.dart';

class QuestionsIndexWidget extends StatelessWidget {
  final List<Question> questions;
  final bool isFilled;
  final bool isSelected;

  const QuestionsIndexWidget({
    super.key,
    required this.questions,
    required this.isFilled,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    double widgetHeight = 40;
    double circleIndexDiameter = 28;
    double separatorWidth = 10;

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: (widgetHeight - circleIndexDiameter) / 2,
            horizontal: 0,
          ),
          height: widgetHeight,
          color: AppColors.grayscaleOffWhite,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: questions.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  SizedBox(width: separatorWidth / 2),
                  Container(
                    width: circleIndexDiameter,
                    height: circleIndexDiameter,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? AppColors.primary
                          : (isFilled
                              ? AppColors.success
                              : AppColors.grayscaleOffWhite),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : (isFilled
                                ? AppColors.success
                                : AppColors.primary),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${++index}',
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.grayscaleOffWhite
                              : (isFilled
                                  ? AppColors.grayscaleOffWhite
                                  : AppColors.primary),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: separatorWidth / 2),
                ],
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShadowContainer(
              widgetHeight: widgetHeight,
              separatorWidth: separatorWidth,
            ),
            ShadowContainer(
              widgetHeight: widgetHeight,
              separatorWidth: separatorWidth,
            ),
          ],
        ),
      ],
    );
  }
}

class ShadowContainer extends StatelessWidget {
  const ShadowContainer({
    super.key,
    required this.widgetHeight,
    required this.separatorWidth,
  });

  final double widgetHeight;
  final double separatorWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0,
      height: widgetHeight,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: separatorWidth,
            color: AppColors.grayscaleBackground,
            offset: const Offset(0, 0),
            spreadRadius: separatorWidth,
          ),
        ],
      ),
    );
  }
}
