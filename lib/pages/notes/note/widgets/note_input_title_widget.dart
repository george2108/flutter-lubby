part of '../note_page.dart';

class NoteInputTitleWidget extends StatelessWidget {
  NoteInputTitleWidget({Key? key}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: context.watch<NoteBloc>().state.titleController,
        maxLength: 500,
        decoration: InputDecoration(
          counterText: '',
          hintText: "Titulo de la nota",
          labelText: 'Titulo',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
