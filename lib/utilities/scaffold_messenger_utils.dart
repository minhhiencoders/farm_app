import 'package:flutter/material.dart';

class ScaffoldMessageUtil {
  static final _messengerKey = GlobalKey<ScaffoldMessengerState>();

  static GlobalKey<ScaffoldMessengerState> get messengerKey => _messengerKey;

  static void showMessage(String message, {Color? backgroundColor, Duration? duration}) {
    final context = _messengerKey.currentContext;
    if (context != null) {
      final snackBar = SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor ?? Colors.black,
        duration: duration ?? const Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // ScaffoldMessenger.of(context).showMaterialBanner(
      //   MaterialBanner(
      //     backgroundColor: Colors.grey.withOpacity(0.5),
      //     content: Text(message), // <- This can be whatever you want
      //     actions: <Widget>[
      //       TextButton(
      //         onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
      //         child: const Text('DISMISS'),
      //       ), // <- So can these
      //     ],
      //   ),
      // );
    }
  }
}
