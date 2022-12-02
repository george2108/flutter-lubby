part of '../note_page.dart';

class NoteInputTitleWidget extends StatelessWidget {
  const NoteInputTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: context.watch<NoteBloc>().state.titleController,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      maxLength: 500,
      decoration: const InputDecoration(
        border: InputBorder.none,
        counterText: '',
        hintText: "Titulo de la nota",
      ),
    );
  }
}
