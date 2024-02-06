import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../labels/domain/entities/label_entity.dart';
import '../bloc/notes_bloc.dart';
import 'labels_view.dart';
import 'notes_view.dart';
import '../../../../ui/widgets/modal_new_tag_widget.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/enums/type_labels.enum.dart';
import '../../../../ui/widgets/menu_drawer.dart';

class NotesMainPage extends StatefulWidget {
  const NotesMainPage({super.key});

  @override
  State<NotesMainPage> createState() => _NotesMainPageState();
}

class _NotesMainPageState extends State<NotesMainPage> {
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
  void initState() {
    super.initState();
    final bloc = BlocProvider.of<NotesBloc>(context);
    bloc.add(NotesGetEvent());
    bloc.add(GetLabelsEvent());
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
            selectedColor: Colors.purple,
          ),
          SalomonBottomBarItem(
            icon: const Icon(CupertinoIcons.tag),
            title: const Text('Etiquetas'),
            selectedColor: Colors.red,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(getTextFAB()),
        icon: const Icon(Icons.add),
        onPressed: () async {
          switch (index) {
            case 0:
              context.push('${Routes().notes.path}/new');
              /* Navigator.of(context).pushNamed(
                noteRoute,
                arguments: NoteRouteSettings(
                  notesContext: context,
                ),
              ); */
              break;
            case 1:
              final LabelEntity? result = await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                elevation: 0,
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
    );
  }
}
