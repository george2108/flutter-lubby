import 'package:flutter/material.dart';
import 'package:lubby_app/src/ui/widgets/select_icons_widget.dart';
import 'package:lubby_app/src/ui/widgets/show_color_picker_widget.dart';

class ModalNewTagWidget extends StatefulWidget {
  const ModalNewTagWidget({Key? key}) : super(key: key);
  @override
  State<ModalNewTagWidget> createState() => _ModalNewTagWidgetState();
}

class _ModalNewTagWidgetState extends State<ModalNewTagWidget> {
  final List<Color> colors = [
    const Color.fromARGB(255, 60, 159, 240),
    const Color.fromARGB(255, 241, 91, 80),
    const Color.fromARGB(255, 92, 212, 96),
    const Color.fromARGB(255, 253, 234, 62),
    const Color.fromARGB(255, 180, 55, 201)
  ];

  final List<IconData> icons = [
    Icons.note,
    Icons.star,
    Icons.notifications_none,
    Icons.folder_outlined,
    Icons.sports_soccer_outlined,
  ];

  Color labelColor = const Color.fromARGB(255, 60, 159, 240);
  int colorIndexSelected = 0;

  IconData labelIcon = Icons.note;
  int iconIndexSelected = 0;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      builder: (_, scrollController) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: const Text('Cancelar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const Text('Nueva etiqueta'),
                  TextButton(
                    child: const Text('Guardar'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: _buildBody(scrollController, context),
            ),
          ],
        ),
      ),
    );
  }

  ListView _buildBody(ScrollController scrollController, BuildContext context) {
    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.all(8.0),
      children: [
        Container(
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: labelColor,
            child: Icon(
              labelIcon,
              color: Theme.of(context).hintColor.withOpacity(1),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Nombre',
            hintText: 'Nombre de la etiqueta',
          ),
        ),
        // colores para la etiqueta
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Color',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextButton(
              child: const Text('Color personalizado'),
              onPressed: () async {
                final pickColor = ShowColorPickerWidget(
                  context: context,
                  color: labelColor,
                );
                final colorPicked = await pickColor.showDialogPickColor();
                if (colorPicked != null) {
                  setState(() {
                    labelColor = colorPicked;
                    colorIndexSelected = -1;
                  });
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            colors.length,
            (index) {
              final colorIndex = colors[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    labelColor = colorIndex;
                    colorIndexSelected = index;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 5,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: colorIndexSelected == index
                          ? Theme.of(context).hintColor
                          : Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: colorIndex,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Icono',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextButton(
              child: const Text('Buscar icono'),
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const SelectIconsWidget(),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            icons.length,
            (index) {
              final iconIndex = icons[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    labelIcon = iconIndex;
                    iconIndexSelected = index;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 5,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: iconIndexSelected == index
                          ? Theme.of(context).hintColor
                          : Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(iconIndex),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
