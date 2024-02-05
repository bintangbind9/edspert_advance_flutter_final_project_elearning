import 'package:flutter/material.dart';

import '../../common/constants/styles.dart';

class SimpleErrorWidget extends StatelessWidget {
  final String message;

  const SimpleErrorWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Styles.mainPadding),
      child: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
