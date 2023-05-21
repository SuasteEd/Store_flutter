import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import '../theme/app_theme.dart';

Future<void> alertError(BuildContext context, String message) {
  return QuickAlert.show(
    context: context,
    type: QuickAlertType.error,
    title: 'Error',
    animType: QuickAlertAnimType.slideInDown,
    confirmBtnColor: AppTheme.secondary,
    width: 300,
    text: message,
    barrierDismissible: false,
    onConfirmBtnTap: () => Navigator.of(context).pop(),
  );
}
