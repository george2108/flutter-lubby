import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/type_labels.enum.dart';
import '../../../../core/utils/get_contrasting_text_color.dart';
import '../../../../ui/widgets/select_label_widget.dart';
import '../../../labels/domain/entities/label_entity.dart';
import '../bloc/passwords_bloc.dart';
import '../../../../ui/widgets/modal_new_tag_widget.dart';

class PasswordSelectCategoryWidget extends StatefulWidget {
  final LabelEntity? categorySelected;
  final Function(LabelEntity value)? onCategorySelected;

  const PasswordSelectCategoryWidget({
    super.key,
    this.categorySelected,
    this.onCategorySelected,
  });

  @override
  State<PasswordSelectCategoryWidget> createState() =>
      _PasswordSelectCategoryWidgetState();
}

class _PasswordSelectCategoryWidgetState
    extends State<PasswordSelectCategoryWidget> {
  LabelEntity? categorySelected;

  @override
  void initState() {
    super.initState();
    categorySelected = widget.categorySelected;
  }

  @override
  void didUpdateWidget(PasswordSelectCategoryWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    categorySelected = widget.categorySelected;
  }

  crearNuevaCategoria() async {
    final category = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      builder: (context) => const ModalNewTagWidget(
        type: TypeLabels.passwords,
      ),
    );

    if (category != null) {
      // ignore: use_build_context_synchronously
      BlocProvider.of<PasswordsBloc>(context).add(
        AddLabelEvent(category),
      );
      widget.onCategorySelected?.call(category);
      setState(() {
        categorySelected = category;
      });
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  /// Muestra un dialogo con las cuentas disponibles
  /// para seleccionar una
  showDialogAccounts() {
    final bloc = BlocProvider.of<PasswordsBloc>(context, listen: false);

    showDialog(
      context: context,
      builder: (_) => SelectLabelWidget(
        type: TypeLabels.passwords,
        labels: bloc.state.labels,
        onLabelSelected: (labelSelected) {
          widget.onCategorySelected?.call(labelSelected);
          setState(() {
            categorySelected = labelSelected;
          });
        },
        onLabelCreatedAndSelected: (labelSelected) {
          widget.onCategorySelected?.call(labelSelected);
          setState(() {
            categorySelected = labelSelected;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showDialogAccounts,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          border: Border.all(
            color: Theme.of(context).highlightColor,
          ),
        ),
        child: Row(
          children: [
            if (categorySelected != null)
              CircleAvatar(
                backgroundColor: categorySelected!.color,
                child: Icon(
                  categorySelected!.icon,
                  color: getContrastingTextColor(categorySelected!.color),
                ),
              ),
            if (categorySelected == null) const Icon(Icons.category_outlined),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (categorySelected != null) const Text('Categoría'),
                  if (categorySelected == null) const SizedBox(height: 5.0),
                  Text(
                    categorySelected != null
                        ? categorySelected!.name
                        : 'Seleccionar una categoría',
                    style: categorySelected != null
                        ? const TextStyle(fontWeight: FontWeight.bold)
                        : const TextStyle(),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_drop_down),
            )
          ],
        ),
      ),
    );
  }
}
