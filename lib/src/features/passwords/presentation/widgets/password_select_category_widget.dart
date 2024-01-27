import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/type_labels.enum.dart';
import '../../../../core/utils/get_contrasting_text_color.dart';
import '../../../labels/domain/entities/label_entity.dart';
import '../bloc/passwords_bloc.dart';
import '../../../../ui/widgets/modal_new_tag_widget.dart';

class PasswordSelectCategoryWidget extends StatefulWidget {
  final LabelEntity? categorySelected;
  final Function(LabelEntity value)? onCategorySelected;
  final BuildContext blocContext;

  const PasswordSelectCategoryWidget({
    super.key,
    this.categorySelected,
    this.onCategorySelected,
    required this.blocContext,
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
      BlocProvider.of<PasswordsBloc>(widget.blocContext).add(
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
    final bloc = BlocProvider.of<PasswordsBloc>(
      widget.blocContext,
      listen: false,
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Seleccionar una categoría'),
        contentPadding: const EdgeInsets.all(8.0),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Nueva categoría'),
                leading: const Icon(Icons.add),
                subtitle: const Text('Crear una nueva categoría'),
                onTap: crearNuevaCategoria,
              ),
              ...bloc.state.labels.map(
                (e) {
                  final category = e;
                  return ListTile(
                    onTap: () {
                      widget.onCategorySelected?.call(category);
                      setState(() {
                        categorySelected = category;
                      });
                      Navigator.pop(context);
                    },
                    title: Text(category.name),
                    leading: CircleAvatar(
                      backgroundColor: category.color,
                      child: Icon(
                        category.icon,
                        color: getContrastingTextColor(category.color),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
        ],
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
