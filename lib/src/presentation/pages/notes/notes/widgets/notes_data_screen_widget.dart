part of '../notes_page.dart';

class NotesDataScreenWidget extends StatelessWidget {
  final List<NoteEntity> notes;

  const NotesDataScreenWidget({
    required this.notes,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    const double appBarHeight = 66.0;
    final bloc = BlocProvider.of<NotesBloc>(context);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          pinned: true,
          floating: true,
          title: const Text('Mis notas'),
          actions: [
            IconButton(
              icon: const Icon(Icons.help_outline_outlined),
              onPressed: () {},
            ),
          ],
          expandedHeight: 150,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 20,
              ),
              alignment: Alignment.bottomCenter,
              height: statusBarHeight + appBarHeight,
              child: TextField(
                controller: bloc.state.searchInputController,
                maxLines: 1,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  prefixIcon: Icon(Icons.search),
                  hintText: "Buscar nota",
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(
            top: 8,
            left: 8,
            right: 8,
            bottom: 100,
          ),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              List.generate(
                notes.length,
                (index) => NoteCardWidget(
                  note: notes[index],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
