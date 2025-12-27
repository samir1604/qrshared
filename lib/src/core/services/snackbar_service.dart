import 'package:flutter/material.dart';

class SnackbarService {
  const SnackbarService._();

  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static void show(
    String message, {
    bool isError = false,
  }) {
    messengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: isError ? Colors.redAccent : Colors.grey.shade800,
        showCloseIcon: true,
        closeIconColor: Colors.white,
        dismissDirection: DismissDirection.startToEnd,
      ),
    );
  }
}
