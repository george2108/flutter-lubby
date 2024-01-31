import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../../../injector.dart';
import '../../../../config/routes_settings/password_route_settings.dart';
import '../../../../core/enums/type_labels.enum.dart';
import '../../../labels/data/repositories/label_repository.dart';
import '../bloc/passwords_bloc.dart';
import 'labels_passwords_view.dart';
import 'passwords_view.dart';
import '../../../../ui/widgets/menu_drawer.dart';
import '../../../../config/routes/routes.dart';
import '../../../labels/domain/entities/label_entity.dart';
import '../../repositories/password_repository.dart';
import '../../../../ui/widgets/modal_new_tag_widget.dart';

class PasswordsMainPage extends StatelessWidget {
  const PasswordsMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordsBloc(
        injector<PasswordRepository>(),
        injector<LabelRepository>(),
      )
        ..add(GetPasswordsEvent())
        ..add(GetLabelsEvent()),
      child: const _Build(),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
class _Build extends StatefulWidget {
  const _Build();

  @override
  State<_Build> createState() => _BuildState();
}

class _BuildState extends State<_Build> {
  int currentIndex = 0;

  get textFAB {
    switch (currentIndex) {
      case 0:
        return 'Nueva contraseña';
      case 1:
        return 'Nueva etiqueta';
      default:
        return 'Nueva contraseña';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PasswordsBloc>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Passwords'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: const Menu(),
      body: IndexedStack(
        index: currentIndex,
        children: const [
          PasswordsView(),
          LabelsPasswordsView(),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(CupertinoIcons.lock),
            title: const Text('Contraseñas'),
            selectedColor: Colors.purple,
          ),
          SalomonBottomBarItem(
            icon: const Icon(CupertinoIcons.tag),
            title: const Text('Etiquetas'),
            selectedColor: Colors.pink,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(textFAB),
        icon: const Icon(Icons.add),
        onPressed: () async {
          switch (currentIndex) {
            case 0:
              Navigator.of(context).pushNamed(
                passwordRoute,
                arguments: PasswordRouteSettings(
                  passwordContext: context,
                  password: null,
                ),
              );
              break;
            case 1:
              final LabelEntity? result = await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                elevation: 0,
                builder: (_) => const ModalNewTagWidget(
                  type: TypeLabels.passwords,
                ),
              );
              if (result != null) {
                bloc.add(AddLabelEvent(result));
              }
              break;
            default:
              // Navigator.pushNamed(context, '/new_password');
              break;
          }
        },
      ),
    );
  }
}
