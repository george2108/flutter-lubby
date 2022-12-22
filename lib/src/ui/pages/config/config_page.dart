import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lubby_app/src/ui/widgets/menu_drawer.dart';

import '../../bloc/theme/theme_bloc.dart';

part 'widgets/change_theme_switch_widget.dart';
part 'widgets/change_theme_system_widget.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          const Text(
            'Elige el tema para la aplicación.',
          ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            child: const ChangeThemeSwitchWidget(),
          ),
          const SizedBox(height: 10),
          const ChangeThemeSystemWidget(),
          const SizedBox(height: 10),
          const Divider(),
        ],
      ),
      drawer: const Menu(),
    );
  }
}
