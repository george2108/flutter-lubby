import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ShowColorPickerWidget {
  final Color? color;
  final BuildContext context;
  bool cancelado = false;
  late Color colorPicked;

  ShowColorPickerWidget({
    required this.context,
    this.color,
  });

  Future<void> showDialogPickColor() async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: color ?? Colors.red,
                  onColorChanged: changeColor,
                  hexInputBar: true,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      cancelado = true;
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Elegir'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeColor(Color color) {
    colorPicked = color;
  }
}
