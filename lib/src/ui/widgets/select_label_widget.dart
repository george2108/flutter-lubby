import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/entities/label_entity.dart';

////////////////////////////////////////////////////////////////////////////////
///
/// Widget para seleccionar etiquetas
///
////////////////////////////////////////////////////////////////////////////////
// ignore: must_be_immutable
class SelectLabelWidget extends StatefulWidget {
  final void Function(LabelEntity labelSelected)? onSelected;
  final List<LabelEntity> labels;
  LabelEntity? labelSelected;

  SelectLabelWidget({
    Key? key,
    this.onSelected,
    required this.labels,
    this.labelSelected,
  }) : super(key: key);

  @override
  State<SelectLabelWidget> createState() => SelectLabelWidgetState();
}

class SelectLabelWidgetState extends State<SelectLabelWidget> {
  late LabelEntity? labelSelected;

  @override
  void initState() {
    super.initState();
    labelSelected = widget.labelSelected;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      onSelected: (value) {
        setState(() {
          labelSelected = value;
        });
        widget.onSelected?.call(labelSelected!);
      },
      itemBuilder: (_) => widget.labels
          .map(
            (label) => PopupMenuItem(
              value: label,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: label.color,
                    child: Icon(
                      label.icon,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Text(label.name),
                ],
              ),
            ),
          )
          .toList(),
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor:
                  labelSelected != null ? labelSelected!.color : Colors.blue,
              child: Icon(
                labelSelected != null
                    ? labelSelected!.icon
                    : CupertinoIcons.tag,
                size: 20,
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              labelSelected != null
                  ? labelSelected!.name
                  : 'Seleccionar etiqueta',
            ),
            const Icon(Icons.arrow_drop_down_outlined),
          ],
        ),
      ),
    );
  }
}
