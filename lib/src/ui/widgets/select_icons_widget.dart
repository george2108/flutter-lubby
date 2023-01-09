import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lubby_app/src/core/constants/category_icons.dart';

class SelectIconsWidget extends StatefulWidget {
  const SelectIconsWidget({super.key});
  @override
  State<SelectIconsWidget> createState() => _SelectIconsWidgetState();
}

class _SelectIconsWidgetState extends State<SelectIconsWidget> {
  final List<String> categories =
      listCategoriesIcons.map((icon) => icon.category).toSet().toList();

  int selectedIconIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Elegir icono'),
      insetPadding: const EdgeInsets.all(10),
      // scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: categories.map((category) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(category),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 10,
                  children: List.generate(listCategoriesIcons.length, (index) {
                    final icon = listCategoriesIcons[index];
                    if (icon.category == category) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          setState(() {
                            selectedIconIndex = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: selectedIconIndex == index
                                ? Theme.of(context).indicatorColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(icon.icon),
                        ),
                      );
                    }
                    return Container();
                  }),
                ),
                const SizedBox(height: 10),
              ],
            );
            /* return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listCategoriesIcons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
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
                }); */
          }).toList(),
        ),
      ),
      actionsPadding: const EdgeInsets.all(5.0),
      buttonPadding: EdgeInsets.zero,
      actions: [
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        const SizedBox(width: 10),
        TextButton(
          onPressed: selectedIconIndex < 0
              ? null
              : () {
                  IconData? iconSelected;
                  if (selectedIconIndex > -1) {
                    iconSelected = listCategoriesIcons[selectedIconIndex].icon;
                  }
                  Navigator.of(context).pop(iconSelected);
                },
          child: const Text('Elegir'),
        )
      ],
    );
  }
}
