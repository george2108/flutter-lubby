import 'package:flutter/material.dart';
import 'package:lubby_app/src/core/constants/colors_default.dart';
import 'package:lubby_app/src/core/constants/iconst_default.dart';
import 'package:lubby_app/src/data/repositories/label_repository.dart';
import 'package:lubby_app/src/domain/entities/label_entity.dart';
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
  Color labelColor = kColorsDefault[0];
  int colorIndexSelected = 0;

  IconData labelIcon = kIconsDefault[0];
  int iconIndexSelected = 0;

  final TextEditingController _textController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  // cuando se agrega una categoria para las finanzas
  TypeLabels typeCategory = TypeLabels.income;

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
                  Text(widget.type == TypeLabels.finances
                      ? 'Nueva categoría'
                      : 'Nueva etiqueta'),
                  TextButton(
                    child: const Text('Guardar'),
                    onPressed: () async {
                      if (!_key.currentState!.validate()) {
                        return;
                      }

                      final label = LabelEntity(
                        name: _textController.text,
                        icon: labelIcon,
                        color: labelColor,
                        type: widget.type == TypeLabels.finances
                            ? typeCategory.name
                            : widget.type.name,
                      );

                      final LabelRepository labelRepository = LabelRepository();
                      final id = await labelRepository.addNewLabel(label);

                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop(label.copyWith(id: id));
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
        Form(
          key: _key,
          child: TextFormField(
            controller: _textController,
            decoration: const InputDecoration(
              labelText: 'Nombre',
              hintText: 'Nombre de la etiqueta',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'El nombre no puede estar vacio';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 15),
        if (widget.type == TypeLabels.finances)
          _chooseTypeMovementeInFinances(context),
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              kColorsDefault.length,
              (index) {
                final colorIndex = kColorsDefault[index];
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              kIconsDefault.length,
              (index) {
                final iconIndex = kIconsDefault[index];
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
        ),
      ],
    );
  }

  Widget _chooseTypeMovementeInFinances(BuildContext context) {
    final TextEditingController textController = TextEditingController(
      text: typeCategory == TypeLabels.income
          ? 'Déposito'
          : typeCategory == TypeLabels.expense
              ? 'Retiro'
              : 'Transferencia',
    );
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      onSelected: (value) {
        setState(() {
          typeCategory = value;
        });
      },
      itemBuilder: (_) {
        return [
          PopupMenuItem(
            value: TypeLabels.income,
            child: Row(
              children: const [
                CircleAvatar(
                  radius: 15,
                  child: Icon(
                    Icons.arrow_upward,
                  ),
                ),
                SizedBox(width: 10.0),
                Text('Déposito'),
              ],
            ),
          ),
          PopupMenuItem(
            value: TypeLabels.expense,
            child: Row(
              children: const [
                CircleAvatar(
                  radius: 15,
                  child: Icon(
                    Icons.arrow_downward,
                  ),
                ),
                SizedBox(width: 10.0),
                Text('Retiro'),
              ],
            ),
          ),
        ];
      },
      child: TextField(
        enabled: false,
        controller: textController,
        decoration: const InputDecoration(
          labelText: 'Tipo de movimiento',
          hintText: 'Tipo de movimiento',
          suffixIcon: Icon(Icons.arrow_drop_down_outlined),
        ),
      ),
      /* child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            Text(
              typeCategory == TypeLabels.income
                  ? 'Déposito'
                  : typeCategory == TypeLabels.expense
                      ? 'Retiro'
                      : 'Transferencia',
            ),
            const Icon(Icons.arrow_drop_down_outlined),
          ],
        ),
      ), */
    );
  }
}
