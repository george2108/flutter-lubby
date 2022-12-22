import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/show_color_picker_widget.dart';
import '../views/note/bloc/note_bloc.dart';

class NoteChangeColorWidget extends StatelessWidget {
  const NoteChangeColorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<NoteBloc>(context, listen: true);

    return GestureDetector(
      onTap: () async {
        final pickColor = ShowColorPickerWidget(
          context: context,
          color: bloc.state.color,
        );
        await pickColor.showDialogPickColor();
        if (!pickColor.cancelado) {
          bloc.add(NoteChangeColor(pickColor.colorPicked));
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
              color: bloc.state.color,
              height: 20,
              width: 50,
            ),
          ],
        ),
      ),
    );
  }
}
