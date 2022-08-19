part of '../passwords_page.dart';

class PasswordsNoDataScreenWidget extends StatelessWidget {
  const PasswordsNoDataScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('Mis contraseñas'),
          actions: [
            IconButton(
              icon: const Icon(Icons.help_outline_outlined),
              onPressed: () {},
            ),
          ],
        ),
        const SliverToBoxAdapter(
          child: NoDataWidget(
            text: 'No tienes contraseñas, crea una',
            lottie: 'assets/password.json',
          ),
        ),
      ],
    );
  }
}
