import 'package:flutter/material.dart';
import 'package:lubby_app/src/core/constants/category_icons.dart';

class SelectIconsWidget extends StatelessWidget {
  const SelectIconsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories =
        listCategoriesIcons.map((icon) => icon.category).toSet().toList();

    return AlertDialog(
      scrollable: true,
      title: const Text('Elegir color'),
      insetPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...categories.map((category) {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (context, index) {
                    final icon = listCategoriesIcons[index];
                    if (icon.category == category) {
                      return InkWell(
                        onTap: () {
                          // Aquí puedes agregar código para seleccionar el icono
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(icon.icon),
                        ),
                      );
                    }
                    return Container();
                  });
            }).toList(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Elegir'),
        )
      ],
    );
  }
}
