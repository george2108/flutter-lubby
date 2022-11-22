part of '../note_page.dart';

class NoteStarWidget extends StatelessWidget {
  const NoteStarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: context.watch<NoteBloc>().state.favorite
          ? const Icon(Icons.star, color: Colors.yellow)
          : const Icon(Icons.star_outline),
      onPressed: () {
        context.read<NoteBloc>().add(NoteMarkFavoriteEvent());
      },
    );
  }
}
