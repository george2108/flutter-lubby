import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBarWidget({
  required String title,
  String? message,
  TypeSnackbar type = TypeSnackbar.success,
}) {
  Get.snackbar(
    title,
    message ?? '',
    animationDuration: Duration(milliseconds: 500),
    margin: EdgeInsets.only(bottom: 50, right: 20, left: 20),
    icon: Icon(
      type == TypeSnackbar.success
          ? Icons.done_outline_rounded
          : type == TypeSnackbar.error
              ? Icons.cancel_outlined
              : Icons.warning_amber_outlined,
      color: type == TypeSnackbar.success
          ? Colors.green
          : type == TypeSnackbar.error
              ? Colors.red
              : Colors.yellow,
    ),
  );
}

enum TypeSnackbar { success, warning, error }
