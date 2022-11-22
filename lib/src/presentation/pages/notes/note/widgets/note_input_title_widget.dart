part of '../note_page.dart';

class NoteInputTitleWidget extends StatelessWidget {
  const NoteInputTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: context.watch<NoteBloc>().state.titleController,
        maxLength: 500,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8.0),
          counterText: '',
          hintText: "Titulo de la nota",
          labelText: 'Titulo',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
      ),
    );
  }
}
