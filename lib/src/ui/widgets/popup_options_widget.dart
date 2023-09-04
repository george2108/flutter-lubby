import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lubby_app/src/core/enums/type_labels.enum.dart';
import 'package:lubby_app/src/core/utils/get_contrasting_text_color.dart';
import 'package:lubby_app/src/domain/entities/label_entity.dart';
import 'package:lubby_app/src/ui/widgets/select_label_widget.dart';
import 'package:lubby_app/src/ui/widgets/show_color_picker_widget.dart';

class PopupOptionsWidget extends StatefulWidget {
  final bool editing;
  final Color color;
  final bool isFavorite;
  final List<LabelEntity>? labels;
  final LabelEntity? labelSelected;
  final TypeLabels type;

  final String? deleteMessage;
  final String? deleteMessageOption;
  final String? colorMessage;
  final bool canSelectImage;

  final void Function(Color colorSelected) onColorNoteChanged;
  final void Function(bool isFavorite) onFavoriteChanged;
  final void Function()? onOptionImagePressed;
  final void Function()? onOptionDeletePressed;
  final void Function(LabelEntity labelSelected)? onLabelSelected;
  final void Function(LabelEntity labelSelected)? onLabelCreatedAndSelected;

  const PopupOptionsWidget({
    super.key,
    this.labels,
    this.labelSelected,
    this.onLabelSelected,
    this.onLabelCreatedAndSelected,
    this.onOptionDeletePressed,
    this.deleteMessage,
    this.deleteMessageOption,
    this.onOptionImagePressed,
    this.colorMessage,
    this.canSelectImage = false,
    required this.editing,
    required this.color,
    required this.isFavorite,
    required this.type,
    required this.onColorNoteChanged,
    required this.onFavoriteChanged,
  });

  @override
  State<PopupOptionsWidget> createState() => _PopupOptionsWidgetState();
}

class _PopupOptionsWidgetState extends State<PopupOptionsWidget> {
  late Color color;
  late bool isFavorite;
  late LabelEntity? labelSelected;

  @override
  void initState() {
    super.initState();
    color = widget.color;
    isFavorite = widget.isFavorite;
    labelSelected = widget.labelSelected;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (_) => [
        PopupMenuItem(
          value: 'color',
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),
              Text(widget.colorMessage ?? 'Color de item'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'favorite',
          child: Row(
            children: [
              isFavorite
                  ? const Icon(Icons.star, color: Colors.yellow)
                  : const Icon(Icons.star_outline),
              const SizedBox(width: 5),
              const Text('Favorita', textAlign: TextAlign.start),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'label',
          child: Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor:
                    labelSelected != null ? labelSelected!.color : Colors.blue,
                child: Icon(
                  labelSelected != null
                      ? labelSelected!.icon
                      : CupertinoIcons.tag,
                  size: 12,
                  color: getContrastingTextColor(
                    labelSelected != null ? labelSelected!.color : Colors.blue,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                labelSelected != null
                    ? labelSelected!.name
                    : 'Agregar etiqueta',
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
        if (widget.canSelectImage)
          const PopupMenuItem(
            value: 'image',
            child: Row(
              children: [
                Icon(Icons.add_photo_alternate_outlined),
                SizedBox(width: 5),
                Text('Agregar imagen', textAlign: TextAlign.start),
              ],
            ),
          ),
        const PopupMenuItem(
          value: 'ayuda',
          child: Row(
            children: [
              Icon(Icons.help_outline),
              SizedBox(width: 5),
              Text('Ayuda', textAlign: TextAlign.start),
            ],
          ),
        ),
        if (widget.editing)
          PopupMenuItem(
            value: 'eliminar',
            child: Row(
              children: [
                const Icon(Icons.delete_outline),
                const SizedBox(width: 5),
                Text(widget.deleteMessageOption ?? 'Eliminar item'),
              ],
            ),
          ),
      ],
      onSelected: (value) async {
        switch (value) {
          case 'color':
            final pickColor = ShowColorPickerWidget(
              context: context,
              color: widget.color,
            );
            final colorPicked = await pickColor.showDialogPickColor();
            if (colorPicked != null) {
              widget.onColorNoteChanged(pickColor.colorPicked);
              setState(() {
                color = colorPicked;
              });
            }
            break;
          case 'favorite':
            setState(() {
              isFavorite = !isFavorite;
              widget.onFavoriteChanged(isFavorite);
            });
            break;
          case 'image':
            widget.onOptionImagePressed?.call();
            break;
          case 'ayuda':
            break;
          case 'eliminar':
            showDialogEiminarItem(context);
            break;
          case 'label':
            chooseLabel();
            break;
        }
      },
    );
  }

  chooseLabel() {
    showDialog(
      context: context,
      builder: (_) => SelectLabelWidget(
          labels: widget.labels ?? [],
          type: widget.type,
          onLabelSelected: (labelSelected) {
            widget.onLabelSelected?.call(labelSelected);
            setState(() {
              this.labelSelected = labelSelected;
            });
          },
          onLabelCreatedAndSelected: (labelSelected) {
            widget.onLabelCreatedAndSelected?.call(labelSelected);
            setState(() {
              this.labelSelected = labelSelected;
            });
          }),
    );
  }

  showDialogEiminarItem(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Text(
                widget.deleteMessage ?? '¿Estas seguro de eliminar este item?',
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      widget.onOptionDeletePressed?.call();
                    },
                    child: const Text('Si, eliminar'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
