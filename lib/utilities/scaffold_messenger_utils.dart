import 'package:flutter/material.dart';

class ScaffoldMessageUtil {
  /// Shows a SnackBar with the given message
  static void showSnackBar(
      BuildContext context, {
        required String message,
        Duration duration = const Duration(seconds: 2),
        Color? backgroundColor,
        SnackBarAction? action,
      }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    // Hide any existing SnackBars
    scaffoldMessenger.hideCurrentSnackBar();

    final snackBar = SnackBar(
      content: Text(message),
      duration: duration,
      backgroundColor: backgroundColor,
      action: action,
      behavior: SnackBarBehavior.floating,
    );

    scaffoldMessenger.showSnackBar(snackBar);
  }

  /// Shows a success message SnackBar
  static void showSuccess(
      BuildContext context, {
        required String message,
        Duration? duration,
      }) {
    showSnackBar(
      context,
      message: message,
      backgroundColor: Colors.green,
      duration: duration ?? const Duration(seconds: 2),
    );
  }

  /// Shows an error message SnackBar
  static void showError(
      BuildContext context, {
        required String message,
        Duration? duration,
      }) {
    showSnackBar(
      context,
      message: message,
      backgroundColor: Colors.red,
      duration: duration ?? const Duration(seconds: 3),
    );
  }

  /// Shows a loading message SnackBar
  static void showLoading(
      BuildContext context, {
        String message = 'Loading...',
      }) {
    showSnackBar(
      context,
      message: message,
      duration: const Duration(days: 365), // Long duration until manually dismissed
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
  }

  /// Shows a material banner
  static void showBanner(
      BuildContext context, {
        required String message,
        required List<Widget> actions,
        Widget? leading,
      }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    scaffoldMessenger.hideCurrentMaterialBanner();

    scaffoldMessenger.showMaterialBanner(
      MaterialBanner(
        content: Text(message),
        actions: actions,
        leading: leading,
      ),
    );
  }

  /// Hides any visible SnackBar
  static void hideSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  /// Hides any visible MaterialBanner
  static void hideBanner(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  }
}