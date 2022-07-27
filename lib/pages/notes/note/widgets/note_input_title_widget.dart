part of '../note_page.dart';

class NoteInputTitleWidget extends StatelessWidget {
  NoteInputTitleWidget({Key? key}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: context.watch<NoteBloc>().state.titleController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: "Titulo de la nota",
        ),
      ),
    );
  }
}
