import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class AppSnackbar {
  static void showSuccess(BuildContext context, String title, String message) {
    _show(context, title, message, ContentType.success);
  }

  static void showError(BuildContext context, String title, String message) {
    _show(context, title, message, ContentType.failure);
  }

  static void showWarning(BuildContext context, String title, String message) {
    _show(context, title, message, ContentType.warning);
  }

  static void showHelp(BuildContext context, String title, String message) {
    _show(context, title, message, ContentType.help);
  }

  static void _show(
      BuildContext context,
      String title,
      String message,
      ContentType type,
      ) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 3),
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: type,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}