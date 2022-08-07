part of '../note_page.dart';

class NoteSaveButtonWidget extends StatelessWidget {
  const NoteSaveButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<NoteBloc>(context, listen: false);
    return ButtonSaveWidget(
      title: context.watch<NoteBloc>().state.editing
          ? 'Actualizar nota'
          : 'Crear nota',
      action: () {
        if (bloc.state.editing) {
          context.read<NoteBloc>().add(NoteUpdatedEvent());
        } else {
          context.read<NoteBloc>().add(NoteCreatedEvent());
        }
      },
      loading: context.watch<NoteBloc>().state.loading,
    );
  }
}
