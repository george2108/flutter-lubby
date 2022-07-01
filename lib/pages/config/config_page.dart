import 'package:flutter/material.dart';
import 'package:lubby_app/providers/config_app_provider.dart';
import 'package:lubby_app/widgets/menu_drawer.dart';
import 'package:provider/provider.dart';

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
          Text(
            'Elige el tema para la aplicación.',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            child: const _CustomSwitch(),
          ),
        ],
      ),
      drawer: Menu(),
    );
  }
}

class _CustomSwitch extends StatelessWidget {
  const _CustomSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final _configAppProvider = Provider.of<ConfigAppProvider>(context);

    final textStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );

    final double heightSwitch = 40;
    final double widthSwitch = size.width * 0.7;

    return Container(
      width: widthSwitch,
      height: heightSwitch,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              _configAppProvider.changeTheme();
            },
            child: Container(
              width: widthSwitch,
              height: heightSwitch,
              decoration: ShapeDecoration(
                color: Theme.of(context).dividerColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text('Light', style: textStyle),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text('Dark', style: textStyle),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedAlign(
            alignment: _configAppProvider.isDarkMode
                ? Alignment.centerRight
                : Alignment.centerLeft,
            duration: const Duration(milliseconds: 200),
            child: Container(
              width: widthSwitch / 2,
              height: heightSwitch,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                shadows: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Icon(
                _configAppProvider.isDarkMode
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
