import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ShowColorPickerWidget {
  final Color? color;
  final BuildContext context;
  late Color colorPicked;

  ShowColorPickerWidget({
    required this.context,
    this.color,
  });

  Future<Color?> showDialogPickColor() async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        scrollable: true,
        title: const Text('Elegir color'),
        insetPadding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SingleChildScrollView(
              child: ColorPicker(
                pickerColor: color ?? Colors.red,
                onColorChanged: changeColor,
                hexInputBar: true,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(colorPicked);
            },
            child: const Text('Elegir'),
          )
        ],
      ),
    );
  }

  void changeColor(Color color) {
    colorPicked = color;
  }
}
