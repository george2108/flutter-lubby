import 'package:flutter/material.dart';

enum TypeSnackbar { success, warning, error }

showCustomSnackBarWidget({
  required String title,
  String? content,
  TypeSnackbar type = TypeSnackbar.success,
  Duration? duration = const Duration(seconds: 2),
}) {
  return SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
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
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.maxFinite,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: double.maxFinite,
                child: Visibility(
                  visible: content != null,
                  child: Text(content ?? ''),
                ),
              )
            ],
          ),
        ),
      ],
    ),
    duration: duration!,
    dismissDirection: DismissDirection.down,
    margin: const EdgeInsets.only(
      // bottom: mediaQuery.size.height - mediaQuery.viewInsets.bottom - 100,
      bottom: 50,
      left: 10.0,
      right: 10.0,
    ),
    behavior: SnackBarBehavior.floating,
  );
}
