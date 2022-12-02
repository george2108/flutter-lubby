part of '../note_page.dart';

class NotePopupWidget extends StatelessWidget {
  const NotePopupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    late NoteBloc bloc = BlocProvider.of<NoteBloc>(context, listen: false);

    return PopupMenuButton(
      itemBuilder: (_) => [
        PopupMenuItem(
          value: 'color',
          child: Row(
            children: const [
              Icon(Icons.color_lens_outlined),
              SizedBox(width: 5),
              Text('Color de nota'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'ayuda',
          child: Row(
            children: const [
              Icon(Icons.help_outline),
              SizedBox(width: 5),
              Text('Ayuda', textAlign: TextAlign.start),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'eliminar',
          child: Row(
            children: const [
              Icon(Icons.delete_outline),
              SizedBox(width: 5),
              Text('Eliminar nota'),
            ],
          ),
        ),
      ],
      onSelected: (value) async {
        if (value == 'eliminar') {
          // ignore: use_build_context_synchronously
          _showDialogEiminarNota(context);
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
