import 'package:flutter/material.dart';

import '../../../widgets/show_color_picker_widget.dart';

class NoteChangeColorWidget extends StatefulWidget {
  final Function(Color color) onColorChanged;
  final Color colorInitial;
  final BuildContext notesContext;

  const NoteChangeColorWidget({
    super.key,
    required this.onColorChanged,
    required this.colorInitial,
    required this.notesContext,
  });

  @override
  State<NoteChangeColorWidget> createState() => _NoteChangeColorWidgetState();
}

class _NoteChangeColorWidgetState extends State<NoteChangeColorWidget> {
  late Color colorPicked;

  @override
  void initState() {
    super.initState();
    colorPicked = widget.colorInitial;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final pickColor = ShowColorPickerWidget(
          context: context,
          color: this.colorPicked,
        );
        final colorPicked = await pickColor.showDialogPickColor();
        if (colorPicked != null) {
          setState(() {
            this.colorPicked = colorPicked;
            widget.onColorChanged(pickColor.colorPicked);
          });
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
              color: colorPicked,
              height: 20,
              width: 50,
            ),
          ],
        ),
      ),
    );
  }
}
