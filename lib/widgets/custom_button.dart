import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.text,
  });
  final Widget text;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppTheme.secondary,
          border: Border.all(color: Colors.black),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.2),
          //     spreadRadius: 2,
          //     blurRadius: 5,
          //     offset: const Offset(0, 3),
          //   ),
          // ],
        ),
        child: MaterialButton(
          onPressed: onPressed,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: text
        ),
      ),
    );
  }
}