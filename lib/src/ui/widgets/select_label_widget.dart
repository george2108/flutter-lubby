import 'package:flutter/material.dart';

import '../../core/enums/type_labels.enum.dart';
import '../../core/utils/get_contrasting_text_color.dart';
import '../../features/labels/domain/entities/label_entity.dart';
import 'modal_new_tag_widget.dart';

////////////////////////////////////////////////////////////////////////////////
///
/// Widget para seleccionar etiquetas
///
////////////////////////////////////////////////////////////////////////////////
// ignore: must_be_immutable
class SelectLabelWidget extends StatefulWidget {
  final void Function(LabelEntity labelSelected)? onLabelSelected;
  final void Function(LabelEntity labelSelected)? onLabelCreatedAndSelected;
  final List<LabelEntity> labels;
  final TypeLabels type;

  const SelectLabelWidget({
    Key? key,
    this.onLabelSelected,
    this.onLabelCreatedAndSelected,
    required this.labels,
    required this.type,
  }) : super(key: key);

  @override
  State<SelectLabelWidget> createState() => SelectLabelWidgetState();
}

class SelectLabelWidgetState extends State<SelectLabelWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Seleccionar una etiqueta'),
      contentPadding: const EdgeInsets.all(8.0),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Nueva etiqueta'),
              leading: const Icon(Icons.add),
              subtitle: const Text('Crear una nueva etiqueta'),
              onTap: crearNuevaCategoria,
            ),
            ...widget.labels.map(
              (e) {
                return ListTile(
                  onTap: () {
                    widget.onLabelSelected?.call(e);
                    Navigator.pop(context);
                  },
                  title: Text(e.name),
                  leading: CircleAvatar(
                    backgroundColor: e.color,
                    child: Icon(
                      e.icon,
                      color: getContrastingTextColor(e.color),
                    ),
                  ),
                );
              },
            ).toList(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
      ],
    );
  }

  crearNuevaCategoria() async {
    final category = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      builder: (context) => ModalNewTagWidget(
        type: widget.type,
      ),
    );

    if (category != null) {
      widget.onLabelCreatedAndSelected?.call(category);
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }
}
