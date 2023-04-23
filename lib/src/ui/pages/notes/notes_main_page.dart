import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lubby_app/injector.dart';
import 'package:lubby_app/src/config/routes/routes.dart';
import 'package:lubby_app/src/domain/entities/label_entity.dart';
import 'package:lubby_app/src/data/repositories/note_repository.dart';
import 'package:lubby_app/src/ui/pages/notes/views/labels_view.dart';
import 'package:lubby_app/src/ui/pages/notes/views/notes_view.dart';
import 'package:lubby_app/src/ui/widgets/modal_new_tag_widget.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../config/routes_settings/note_route_settings.dart';
import '../../../core/enums/type_labels.enum.dart';
import '../../../data/repositories/label_repository.dart';
import '../../widgets/menu_drawer.dart';
import 'bloc/notes_bloc.dart';

class NotesMainPage extends StatelessWidget {
  const NotesMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesBloc(
        injector<NoteRepository>(),
        injector<LabelRepository>(),
      )
        ..add(NotesGetEvent())
        ..add(GetLabelsEvent()),
      child: const _BuildPage(),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
class _BuildPage extends StatefulWidget {
  const _BuildPage();
  @override
  State<_BuildPage> createState() => __BuildPageState();
}

class __BuildPageState extends State<_BuildPage> {
  int index = 0;

  getTextFAB() {
    switch (index) {
      case 0:
        return 'Nueva nota';
      case 1:
        return 'Nueva etiqueta';
      default:
        return 'Nueva nota';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<NotesBloc>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis notas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      drawer: const Menu(),
      body: IndexedStack(
        index: index,
        children: const [
          NotesView(),
          LabelsView(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(getTextFAB()),
        icon: const Icon(Icons.add),
        onPressed: () async {
          switch (index) {
            case 0:
              Navigator.of(context).pushNamed(
                noteRoute,
                arguments: NoteRouteSettings(
                  notesContext: context,
                ),
              );
              break;
            case 1:
              final LabelEntity? result = await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => const ModalNewTagWidget(
                  type: TypeLabels.notes,
                ),
              );
              if (result != null) {
                bloc.add(AddLabelEvent(result));
              }
              break;
          }
        },
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: index,
        onTap: (index) {
          setState(() {
            this.index = index;
          });
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.note_alt_outlined),
            title: const Text('Mis notas'),
            selectedColor: Theme.of(context).indicatorColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(CupertinoIcons.tag),
            title: const Text('Etiquetas'),
            selectedColor: Theme.of(context).indicatorColor,
          ),
        ],
      ),
    );
  }
}
