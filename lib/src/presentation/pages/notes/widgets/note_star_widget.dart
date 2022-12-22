import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../views/note/bloc/note_bloc.dart';

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
