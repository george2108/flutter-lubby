import 'package:flutter/material.dart';
import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/note_model.dart';

class SearchNoteDelegate extends SearchDelegate {
  int contador = 0;
  @override
  String? get searchFieldLabel => 'Buscar nota';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, []);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.trim().length == 0) {
      return const Center(
        child: Text('Aquí aparecera el resultado de tu búsqueda...'),
      );
    }
    return FutureBuilder(
      future: DatabaseProvider.db.searchNote(query),
      builder: (BuildContext context, AsyncSnapshot<List<NoteModel>> snapshot) {
        print(snapshot.data);
        return const Text('hola');
      },
    );
  }
}
