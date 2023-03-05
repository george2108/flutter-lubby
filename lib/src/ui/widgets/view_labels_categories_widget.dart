import 'package:flutter/material.dart';

import '../../data/entities/label_entity.dart';

class ViewLabelsCategoriesWidget extends StatefulWidget {
  final List<LabelEntity> labels;
  final Function(int? indexLabelSelected)? onLabelSelected;

  const ViewLabelsCategoriesWidget({
    Key? key,
    required this.labels,
    this.onLabelSelected,
  }) : super(key: key);

  @override
  State<ViewLabelsCategoriesWidget> createState() =>
      ViewLabelsCategoriesWidgetState();
}

class ViewLabelsCategoriesWidgetState
    extends State<ViewLabelsCategoriesWidget> {
  int _indexLabelSelected = -1;

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
                            _indexLabelSelected = -1;
                          });
                          if (widget.onLabelSelected != null) {
                            widget.onLabelSelected!(null);
                          }
                        },
                        child: Chip(
                          label: const Text('Todas'),
                          backgroundColor: _indexLabelSelected == -1
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
                              _indexLabelSelected = index;
                            });
                            if (widget.onLabelSelected != null) {
                              widget.onLabelSelected!(_indexLabelSelected);
                            }
                          },
                          child: Chip(
                            backgroundColor: _indexLabelSelected == index
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
