part of '../notes_page.dart';

class NotesNoDataScreenWidget extends StatelessWidget {
  final Widget child;

  const NotesNoDataScreenWidget({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('Mis notas'),
          actions: [
            IconButton(
              icon: const Icon(Icons.help_outline),
              onPressed: () {},
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: child,
          ),
        ),
      ],
    );
  }
}
