import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_snackbar_widget.dart';

void copyClipboardWidget(
  String element,
  String title,
  String message,
  BuildContext context,
) {
  Clipboard.setData(ClipboardData(text: element)).then(
    (value) => ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBarWidget(
        title: title,
        description: message,
      ),
    ),
  );
}
