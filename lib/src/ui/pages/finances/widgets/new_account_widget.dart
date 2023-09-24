import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lubby_app/src/core/constants/colors_default.dart';
import 'package:lubby_app/src/core/constants/iconst_default.dart';
import 'package:lubby_app/src/domain/entities/finances/account_entity.dart';
import 'package:lubby_app/src/ui/widgets/header_modal_bottom_widget.dart';
import 'package:lubby_app/src/ui/widgets/select_icons_widget.dart';
import 'package:lubby_app/src/ui/widgets/show_color_picker_widget.dart';
import 'package:lubby_app/src/ui/widgets/custom_snackbar_widget.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../bloc/finances_bloc.dart';

class NewAccountWidget extends StatefulWidget {
  final BuildContext blocContext;
  const NewAccountWidget({
    Key? key,
    required this.blocContext,
  }) : super(key: key);
  @override
  State<NewAccountWidget> createState() => _NewAccountWidgetState();
}

class _NewAccountWidgetState extends State<NewAccountWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _initialBalanceController =
      TextEditingController();

  Color accountColor = kColorsDefault[0];
  int colorIndexSelected = 0;
  IconData accountIcon = kIconsDefault[0];
  int iconIndexSelected = 0;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final balanceAcountMask = MaskTextInputFormatter(
    mask: '####################',
    filter: {
      "#": RegExp(r'^-?[0-9]{0,10}(\.[0-9]{0,2})?$'),
    },
  );

  buscarIcono() async {
    final icon = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const SelectIconsWidget(),
    );
    if (icon != null) {
      setState(() {
        accountIcon = icon;
        iconIndexSelected = -1;
      });
    }
  }

  saveAccount() {
    if (!_key.currentState!.validate()) {
      return;
    }

    final account = AccountEntity(
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      balance: double.parse(
        _initialBalanceController.text.trim(),
      ),
      icon: accountIcon,
      color: accountColor,
      createdAt: DateTime.now(),
    );

    final bloc = BlocProvider.of<FinancesBloc>(widget.blocContext);
    bloc.add(CreateAccountEvent(account));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FinancesBloc, FinancesState>(
      bloc: BlocProvider.of<FinancesBloc>(widget.blocContext),
      listener: (context, state) {},
      listenWhen: (previous, current) {
        if (current.accounts.length > previous.accounts.length) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBarWidget(
              title: 'Cuenta creada',
              description: 'Se ha creado la cuenta exitosamente',
            ),
          );
          Navigator.of(context).pop(current.accounts.last);
        }
        return false;
      },
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.9,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return _content(context, scrollController);
        },
      ),
    );
  }

  Widget _content(BuildContext context, ScrollController scrollController) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: [
          HeaderModalBottomWidget(
            onCancel: () {
              Navigator.of(context).pop();
            },
            onSave: saveAccount,
            title: 'Nueva cuenta',
          ),
          Expanded(
            child: Form(
              key: _key,
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.all(8.0),
                children: [
                  const SizedBox(height: 15.0),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      hintText: 'Nombre de la cuenta',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'El nombre es requerido';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 15.0),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Descripción',
                      hintText: 'Descripción de la cuenta',
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  TextFormField(
                    controller: _initialBalanceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Saldo inicial',
                      hintText: 'Saldo inicial de la cuenta',
                      icon: Text(
                        'MXN',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    inputFormatters: [balanceAcountMask],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'El monto inicial es requerido';
                      }

                      final n = num.tryParse(value);
                      if (n == null) {
                        return '"$value" no es un número válido';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 15.0),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      SizedBox(width: 10.0),
                      Text('Personalizar Icono'),
                      SizedBox(width: 10.0),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  GestureDetector(
                    onTap: buscarIcono,
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundColor: accountColor,
                      child: Icon(
                        accountIcon,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Color'),
                      TextButton(
                        child: const Text('Personalizar color'),
                        onPressed: () async {
                          final pickColor = ShowColorPickerWidget(
                            context: context,
                            color: accountColor,
                          );
                          final colorPicked =
                              await pickColor.showDialogPickColor();
                          if (colorPicked != null) {
                            setState(() {
                              accountColor = colorPicked;
                              colorIndexSelected = -1;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  _defaultColorsList(context),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Icono'),
                      TextButton(
                        onPressed: buscarIcono,
                        child: const Text('Buscar icono'),
                      ),
                    ],
                  ),
                  _defaultIconsLIst(context)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _defaultIconsLIst(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          kIconsDefault.length,
          (index) {
            final iconIndex = kIconsDefault[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  accountIcon = iconIndex;
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
    );
  }

  Widget _defaultColorsList(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          kColorsDefault.length,
          (index) {
            final colorIndex = kColorsDefault[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  accountColor = colorIndex;
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
    );
  }
}
