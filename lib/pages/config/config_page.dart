import 'package:flutter/material.dart';
import 'package:lubby_app/widgets/menu_drawer.dart';

class ConfigPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
      ),
      drawer: Menu(),
    );
  }
}
