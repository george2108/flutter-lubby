import 'package:flutter/material.dart';
import 'package:lubby_app/src/data/entities/label_entity.dart';
import 'package:lubby_app/src/ui/widgets/select_icons_widget.dart';
import 'package:lubby_app/src/ui/widgets/show_color_picker_widget.dart';

import '../../core/enums/type_labels.enum.dart';

class ModalNewTagWidget extends StatefulWidget {
  final TypeLabels type;

  const ModalNewTagWidget({Key? key, required this.type}) : super(key: key);
  @override
  State<ModalNewTagWidget> createState() => _ModalNewTagWidgetState();
}

class _ModalNewTagWidgetState extends State<ModalNewTagWidget> {
  final List<Color> colors = [
    const Color.fromARGB(255, 60, 159, 240),
    const Color.fromARGB(255, 241, 91, 80),
    const Color.fromARGB(255, 92, 212, 96),
    const Color.fromARGB(255, 253, 234, 62),
    const Color.fromARGB(255, 180, 55, 201),
    const Color.fromARGB(255, 15, 107, 143),
    const Color.fromARGB(228, 173, 25, 195),
    const Color.fromARGB(255, 81, 184, 60),
    const Color.fromARGB(255, 218, 110, 16),
    const Color.fromARGB(255, 106, 52, 25),
  ];

  final List<IconData> icons = [
    Icons.notifications_none,
    Icons.folder_outlined,
    Icons.sports_soccer_outlined,
    Icons.motorcycle,
    Icons.local_florist_outlined,
    Icons.local_pizza_outlined,
    Icons.local_cafe_outlined,
    Icons.local_bar_outlined,
    Icons.local_car_wash_outlined,
    Icons.local_gas_station_outlined,
    Icons.local_laundry_service_outlined,
    Icons.local_mall_outlined,
  ];

  Color labelColor = const Color.fromARGB(255, 60, 159, 240);
  int colorIndexSelected = 0;

  IconData labelIcon = Icons.notifications_none;
  int iconIndexSelected = 0;

  final TextEditingController _textController = TextEditingController();

  buscarIcono() async {
    final icon = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const SelectIconsWidget(),
    );
    if (icon != null) {
      setState(() {
        labelIcon = icon;
        iconIndexSelected = -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
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
                    onPressed: () {
                      final label = LabelEntity(
                        name: _textController.text,
                        icon: labelIcon,
                        color: labelColor,
                        type: widget.type.name,
                      );
                      Navigator.of(context).pop(label);
                    },
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
          child: GestureDetector(
            onTap: buscarIcono,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: labelColor,
              child: Icon(
                labelIcon,
                color: Theme.of(context).hintColor.withOpacity(1),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _textController,
          decoration: InputDecoration(
            labelText: 'Nombre',
            hintText: 'Nombre de la etiqueta',
          ),
        ),
        // colores para la etiqueta
        const SizedBox(height: 10),
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
        Wrap(
          spacing: 10,
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
        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Icono',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: buscarIcono,
              child: const Text('Buscar icono'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
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
