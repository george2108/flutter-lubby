part of '../passwords_page.dart';

class PasswordsDataScreenWidget extends StatelessWidget {
  const PasswordsDataScreenWidget({
    Key? key,
    required this.passwords,
  }) : super(key: key);

  final List<PasswordEntity> passwords;

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    const double appBarHeight = 66.0;
    final bloc = BlocProvider.of<PasswordsBloc>(context);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          pinned: true,
          floating: true,
          title: const Text('Mis contraseñas'),
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
                  prefixIcon: Icon(Icons.search),
                  hintText: "Buscar contraseña",
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
                passwords.length,
                (index) => PasswordsCardInfoWidget(
                  passwordModel: passwords[index],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
