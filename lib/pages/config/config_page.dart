import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lubby_app/bloc/theme/theme_bloc.dart';
import 'package:lubby_app/widgets/menu_drawer.dart';

part 'widgets/change_theme_switch_widget.dart';
part 'widgets/change_theme_system_widget.dart';

class ConfigPage extends StatelessWidget {
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
      drawer: Menu(),
    );
  }
}
