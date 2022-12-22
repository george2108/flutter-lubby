import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lubby_app/src/presentation/pages/notes/views/labels_view.dart';
import 'package:lubby_app/src/presentation/pages/notes/views/note/note_view.dart';
import 'package:lubby_app/src/presentation/pages/notes/views/notes_view.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../widgets/menu_drawer.dart';
import 'bloc/notes_bloc.dart';

class NotesMainPage extends StatelessWidget {
  const NotesMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesBloc()..add(NotesGetEvent()),
      child: const _BuildPage(),
    );
  }
}

class _BuildPage extends StatefulWidget {
  const _BuildPage();
  @override
  State<_BuildPage> createState() => __BuildPageState();
}

class __BuildPageState extends State<_BuildPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
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
        label: Text(index == 0 ? 'Nueva nota' : 'Nueva etiqueta'),
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 500),
              pageBuilder: ((_, animation, __) => FadeTransition(
                    opacity: animation,
                    child: NotePage(notesContext: context),
                  )),
            ),
          );
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
            icon: const Icon(Icons.label_important_outline_rounded),
            title: const Text('Etiquetas'),
            selectedColor: Theme.of(context).indicatorColor,
          ),
        ],
      ),
    );
  }
}
