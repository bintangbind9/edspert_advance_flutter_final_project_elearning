import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color foregroundColor;
  final Color backgroundColor;
  final String logo;
  final String text;

  const SocialLoginButton({
    super.key,
    this.onPressed,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.logo,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .5,
        height: 40,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(logo),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: foregroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
