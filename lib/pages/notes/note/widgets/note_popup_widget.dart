part of '../note_page.dart';

class NotePopupWidget extends StatelessWidget {
  late final NoteBloc bloc;

  NotePopupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<NoteBloc>(context, listen: false);

    return PopupMenuButton(
      itemBuilder: (_) => [
        PopupMenuItem(
          child: Row(
            children: [
              const Icon(Icons.color_lens_outlined),
              const SizedBox(width: 5),
              const Text('Color de nota'),
            ],
          ),
          value: 'color',
        ),
        PopupMenuItem(
          child: Row(
            children: [
              const Icon(Icons.help_outline),
              const SizedBox(width: 5),
              const Text('Ayuda', textAlign: TextAlign.start),
            ],
          ),
          value: 'ayuda',
        ),
        PopupMenuItem(
          child: Row(
            children: [
              const Icon(Icons.delete_outline),
              const SizedBox(width: 5),
              const Text('Eliminar nota'),
            ],
          ),
          value: 'eliminar',
        ),
      ],
      onSelected: (value) async {
        if (value == 'color') {
          final pickColor = ShowColorPickerWidget(
            context: context,
            color: bloc.state.color,
          );
          await pickColor.showDialogPickColor();
          if (!pickColor.cancelado) {
            bloc.add(NoteChangeColor(pickColor.colorPicked));
          }
        }
        if (value == 'eliminar') {
          this._showDialogEiminarNota(context);
        }
      },
    );
  }

  _showDialogEiminarNota(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              const Text('¿Estas seguro de eliminar esta nota?'),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      context.read<NoteBloc>().add(NoteDeletedEvent());
                    },
                    child: const Text('Si, eliminar'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
