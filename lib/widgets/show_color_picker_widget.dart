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

  Future<dynamic> showDialogPickColor() async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: color ?? Colors.red,
                    onColorChanged: changeColor,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      this.cancelado = true;
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
    this.colorPicked = color;
  }
}
