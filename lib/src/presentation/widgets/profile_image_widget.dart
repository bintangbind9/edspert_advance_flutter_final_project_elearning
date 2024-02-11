import 'dart:io';

import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  final double diameter;
  final bool isFromFile;
  final String path;
  final Color foregroundColor;
  final Color backgroundColor;

  const ProfileImageWidget({
    super.key,
    required this.diameter,
    required this.isFromFile,
    required this.path,
    required this.foregroundColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(diameter / 2),
      child: Container(
        color: backgroundColor,
        width: diameter,
        height: diameter,
        child: isFromFile
            ? Image.file(
                File(path),
                errorBuilder: (context, error, stackTrace) =>
                    buildDefaultProfileIcon(),
              )
            : Image.network(
                path,
                errorBuilder: (context, error, stackTrace) =>
                    buildDefaultProfileIcon(),
              ),
      ),
    );
  }

  Icon buildDefaultProfileIcon() {
    return Icon(
      Icons.person,
      color: foregroundColor,
      size: diameter * .8,
    );
  }
}
