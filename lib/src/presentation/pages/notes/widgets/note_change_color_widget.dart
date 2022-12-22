import 'package:flutter/material.dart';

import '../../../widgets/show_color_picker_widget.dart';

class NoteChangeColorWidget extends StatefulWidget {
  final Function(Color color) onColorChanged;
  final Color colorInitial;
  final BuildContext notesContext;
  late Color colorSelected;

  NoteChangeColorWidget({
    super.key,
    required this.onColorChanged,
    required this.colorInitial,
    required this.notesContext,
  }) : colorSelected = colorInitial;

  @override
  State<NoteChangeColorWidget> createState() => _NoteChangeColorWidgetState();
}

class _NoteChangeColorWidgetState extends State<NoteChangeColorWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final pickColor = ShowColorPickerWidget(
          context: context,
          color: widget.colorSelected,
        );
        await pickColor.showDialogPickColor();
        if (!pickColor.cancelado) {
          widget.colorSelected = pickColor.colorPicked;
          widget.onColorChanged(pickColor.colorPicked);
          setState(() {});
        }
      },
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).highlightColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          children: [
            const Text('Color'),
            const SizedBox(width: 10),
            Container(
              color: widget.colorSelected,
              height: 20,
              width: 50,
            ),
          ],
        ),
      ),
    );
  }
}
