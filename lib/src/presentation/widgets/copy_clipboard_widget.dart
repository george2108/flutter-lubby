import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lubby_app/src/presentation/widgets/show_snackbar_widget.dart';

void copyClipboardWidget(
  String element,
  String title,
  String message,
  BuildContext context,
) {
  Clipboard.setData(ClipboardData(text: element)).then(
    (value) => ScaffoldMessenger.of(context).showSnackBar(
      showCustomSnackBarWidget(
        title: title,
        content: message,
      ),
    ),
  );
}
