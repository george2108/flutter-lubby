import 'package:flutter/material.dart';

import '../../features/labels/domain/entities/label_entity.dart';

class ViewLabelsCategoriesWidget extends StatefulWidget {
  final List<LabelEntity> labels;
  final Function(LabelEntity? labelSelected)? onLabelSelected;
  final LabelEntity? initialLabel;

  const ViewLabelsCategoriesWidget({
    super.key,
    required this.labels,
    this.onLabelSelected,
    this.initialLabel,
  });

  @override
  State<ViewLabelsCategoriesWidget> createState() =>
      ViewLabelsCategoriesWidgetState();
}

class ViewLabelsCategoriesWidgetState
    extends State<ViewLabelsCategoriesWidget> {
  LabelEntity? _labelSelected;

  @override
  void initState() {
    super.initState();
    if (widget.initialLabel != null) {
      _labelSelected = widget.initialLabel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _labelSelected = null;
                          });
                          widget.onLabelSelected?.call(null);
                        },
                        child: Chip(
                          label: const Text('Todas'),
                          backgroundColor: _labelSelected == null
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).chipTheme.backgroundColor,
                        ),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                  ...List.generate(widget.labels.length, (index) {
                    final label = widget.labels[index];
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _labelSelected = label;
                            });
                            widget.onLabelSelected?.call(label);
                          },
                          child: Chip(
                            backgroundColor: _labelSelected == label
                                ? label.color.withOpacity(0.5)
                                : Theme.of(context).chipTheme.backgroundColor,
                            avatar: CircleAvatar(
                              backgroundColor: label.color,
                              child: Icon(label.icon, size: 16),
                            ),
                            label: Text(label.name),
                          ),
                        ),
                        const SizedBox(width: 5),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
          /* TextButton(
            onPressed: () {},
            child: const Text('Nota rapida'),
          ), */
        ],
      ),
    );
  }
}
