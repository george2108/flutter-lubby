part of '../todos_page.dart';

class TodosDataScreenWidget extends StatelessWidget {
  final List<ToDoModel> todos;

  const TodosDataScreenWidget({
    required this.todos,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double appBarHeight = 66.0;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          pinned: true,
          title: const Text('Mis listas de tareas'),
          actions: [
            IconButton(
              icon: const Icon(Icons.help_outline_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.filter_list_outlined),
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
                controller: TextEditingController(),
                maxLines: 1,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
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
                todos.length,
                (index) => TodosDetailCardWidget(
                  data: todos[index],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
