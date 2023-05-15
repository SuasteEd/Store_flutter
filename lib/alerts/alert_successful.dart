import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import '../theme/app_theme.dart';

Future<void> alertSucces(BuildContext context, String message) {
    return Future.delayed(const Duration(seconds: 1), () {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Success',
        animType: QuickAlertAnimType.slideInDown,
        confirmBtnColor: AppTheme.secondary,
        width: 300,
        text: message,
        
        barrierDismissible: false,
        onConfirmBtnTap: () => Navigator.of(context)
            .pushNamedAndRemoveUntil('home', (route) => false),
      );
    });
  }