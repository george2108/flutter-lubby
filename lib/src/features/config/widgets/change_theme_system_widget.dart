part of './../config_page.dart';

class ChangeThemeSystemWidget extends StatelessWidget {
  const ChangeThemeSystemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeMode>(
      builder: (context, state) {
        return CheckboxListTile(
          value: state == ThemeMode.system,
          title: const Text('Usar tema del dispositivo'),
          onChanged: (value) {},
        );
      },
    );
  }
}
