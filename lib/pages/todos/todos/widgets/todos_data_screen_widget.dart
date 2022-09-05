part of '../todos_page.dart';

class TodosDataScreenWidget extends StatelessWidget {
  final List<ToDoModel> todos;

  TodosDataScreenWidget({
    required this.todos,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double appBarHeight = 66.0;
    final bloc = BlocProvider.of<TodosBloc>(context);

    return CustomScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          pinned: true,
          floating: true,
          title: const Text('Mis listas de tareas'),
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: bloc.state.searchInputController,
                      maxLines: 1,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {},
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        hintText: "Buscar lista de tareas",
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_list_outlined),
                    onPressed: () {
                      print('filtros');
                    },
                  ),
                ],
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
