part of '../note_page.dart';

class NoteSaveButtonWidget extends StatelessWidget {
  const NoteSaveButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state is NoteLoadedState) {
          return ButtonSaveWidget(
            title: state.editing ? 'Actualizar nota' : 'Crear nota',
            action: () {
              if (state.editing) {
                context.read<NoteBloc>().add(NoteUpdatedEvent());
              } else {
                context.read<NoteBloc>().add(NoteCreatedEvent());
              }
            },
            loading: state.loading,
          );
        }

        return Container();
      },
    );
  }
}
