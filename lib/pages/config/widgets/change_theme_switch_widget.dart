part of '../config_page.dart';

class ChangeThemeSwitchWidget extends StatelessWidget {
  const ChangeThemeSwitchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final textStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );

    final double heightSwitch = 40;
    final double widthSwitch = size.width * 0.7;

    return BlocBuilder<ThemeBloc, ThemeMode>(
      builder: (context, state) {
        return Container(
          width: widthSwitch,
          height: heightSwitch,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  context.read<ThemeBloc>().add(
                        ChangeThemeEvent(
                          state == ThemeMode.dark
                              ? ThemeMode.light
                              : ThemeMode.dark,
                        ),
                      );
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
                alignment: state == ThemeMode.dark
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
                    state == ThemeMode.dark
                        ? Icons.dark_mode
                        : Icons.light_mode,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
