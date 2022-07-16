part of '../note_page.dart';

class NoteStarWidget extends StatelessWidget {
  const NoteStarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      if (state is NoteLoadedState) {
        return IconButton(
          icon: state.favorite
              ? const Icon(Icons.star, color: Colors.yellow)
              : const Icon(Icons.star_outline),
          onPressed: () {
            context.read<NoteBloc>().add(NoteMarkFavoriteEvent());
          },
        );
      }
      return Container();
    });
  }
}
