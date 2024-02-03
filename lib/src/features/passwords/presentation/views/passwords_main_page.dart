import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../../core/constants/responsive_breakpoints.dart';
import '../../../../core/enums/type_labels.enum.dart';
import '../bloc/passwords_bloc.dart';
import 'labels_passwords_view.dart';
import 'passwords_view.dart';
import '../../../../ui/widgets/menu_drawer.dart';
import '../../../../config/routes/routes.dart';
import '../../../labels/domain/entities/label_entity.dart';
import '../../../../ui/widgets/modal_new_tag_widget.dart';

class PasswordsMainPage extends StatefulWidget {
  const PasswordsMainPage({super.key});

  @override
  State<PasswordsMainPage> createState() => _PasswordsMainPageState();
}

class _PasswordsMainPageState extends State<PasswordsMainPage> {
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
  void initState() {
    super.initState();

    final bloc = BlocProvider.of<PasswordsBloc>(context, listen: false);
    bloc.add(const GetPasswordsEvent());
    bloc.add(GetLabelsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PasswordsBloc>(context, listen: false);
    final isMobile = MediaQuery.of(context).size.width < kMobileBreakpoint;

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
      drawer: isMobile ? const Menu() : null,
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
              /* Navigator.of(context).pushNamed(
                passwordRoute,
                arguments: PasswordRouteSettings(
                  passwordContext: context,
                  password: null,
                ),
              ); */
              context.push('${Routes().passwords.path}/new');
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
