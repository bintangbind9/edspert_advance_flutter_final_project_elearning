import 'package:flutter/material.dart';

class SubSection extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final Widget child;
  final double? horizontalTitlePadding;
  final double? verticalTitlePadding;

  const SubSection({
    super.key,
    required this.title,
    this.trailing,
    required this.child,
    this.horizontalTitlePadding,
    this.verticalTitlePadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalTitlePadding ?? 0,
            vertical: verticalTitlePadding ?? 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing ?? const SizedBox(),
            ],
          ),
        ),
        child,
      ],
    );
  }
}
