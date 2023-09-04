import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lubby_app/src/core/enums/type_labels.enum.dart';
import 'package:lubby_app/src/domain/entities/label_entity.dart';
import 'package:lubby_app/src/ui/widgets/popup_options_widget.dart';
import 'package:lubby_app/src/ui/widgets/custom_snackbar_widget.dart';

import '../../../../domain/entities/password_entity.dart';
import '../../../widgets/select_icons_widget.dart';
import '../../../widgets/show_color_picker_widget.dart';
import '../bloc/passwords_bloc.dart';

class PasswordView extends StatefulWidget {
  final PasswordEntity? password;
  final BuildContext passwordContext;

  const PasswordView({super.key, this.password, required this.passwordContext});
  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  late final TextEditingController titleController;
  late final TextEditingController passwordController;
  late final TextEditingController userController;
  late final TextEditingController urlController;
  late final TextEditingController notesController;
  late final TextEditingController descriptionController;

  late bool favorite;
  LabelEntity? labelSelected;
  IconData? iconSelected;
  late Color colorSelected;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool editing = false;

  @override
  void initState() {
    editing = widget.password != null;
    favorite = widget.password?.favorite ?? false;

    iconSelected = widget.password?.icon ?? Icons.lock;
    colorSelected = widget.password?.color ?? Colors.blue;

    // TODO: IMPLEMENTAR LABELS
    labelSelected = widget.password?.label;

    titleController = TextEditingController(
      text: widget.password?.title ?? '',
    );
    passwordController = TextEditingController(
      text: widget.password?.password ?? '',
    );
    userController = TextEditingController(
      text: widget.password?.user ?? '',
    );
    urlController = TextEditingController(
      text: widget.password?.url ?? '',
    );
    notesController = TextEditingController(
      text: widget.password?.notas ?? '',
    );
    descriptionController = TextEditingController(
      text: widget.password?.description ?? '',
    );

    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    passwordController.dispose();
    userController.dispose();
    urlController.dispose();
    notesController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  void onPressed() {
    final bloc = BlocProvider.of<PasswordsBloc>(widget.passwordContext);

    if (!formKey.currentState!.validate()) {
      return;
    }

    final password = PasswordEntity(
      id: widget.password?.id,
      title: titleController.text.trim(),
      password: passwordController.text.trim(),
      user: userController.text.trim(),
      url: urlController.text.trim(),
      description: descriptionController.text.trim(),
      color: colorSelected,
      favorite: favorite,
      notas: notesController.text.trim(),
      createdAt: DateTime.now(),
      icon: iconSelected!,
      labelId: labelSelected?.id,
      label: labelSelected,
    );

    if (editing) {
      bloc.add(UpdatePasswordEvent(password));
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBarWidget(
          title: 'Contraseña actualizada',
          description: 'La contraseña se actualizó correctamente',
        ),
      );
      return;
    }

    bloc.add(CreatePasswordEvent(password));
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBarWidget(
        title: 'Contraseña creada',
        description: 'La contraseña se creó correctamente',
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PasswordsBloc>(
      widget.passwordContext,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contraseña'),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.done),
            label: const Text('Guardar'),
            onPressed: onPressed,
          ),
          PopupOptionsWidget(
            editing: editing,
            color: colorSelected,
            isFavorite: favorite,
            type: TypeLabels.passwords,
            colorMessage: 'Color de la contraseña',
            deleteMessageOption: 'Eliminar contraseña',
            onColorNoteChanged: (color) {
              colorSelected = color;
            },
            onFavoriteChanged: (favorite) {
              this.favorite = favorite;
            },
            onLabelCreatedAndSelected: (labelSelected) {
              labelSelected = labelSelected;
              bloc.add(AddLabelEvent(labelSelected));
            },
            onLabelSelected: (labelSelected) {
              labelSelected = labelSelected;
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: formKey,
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: colorSelected,
                        radius: 30.0,
                        child: Icon(
                          iconSelected,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            child: const Text('Cambiar icono'),
                            onPressed: () async {
                              final icon = await showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) => const SelectIconsWidget(),
                              );

                              if (icon == null) return;

                              setState(() {
                                iconSelected = icon;
                              });
                            },
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final pickColor = ShowColorPickerWidget(
                                context: context,
                                color: colorSelected,
                              );
                              final colorPicked =
                                  await pickColor.showDialogPickColor();
                              if (colorPicked != null) {
                                setState(() {
                                  colorSelected = colorPicked;
                                });
                              }
                            },
                            child: const Text('Cambiar color'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: titleController,
                    maxLines: 1,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: 'Titulo de la contraseña',
                      labelText: 'Titulo',
                    ),
                    validator: (_) {
                      return titleController.text.trim().isNotEmpty
                          ? null
                          : 'Titulo requerido';
                    },
                  ),
                  const SizedBox(height: 17.0),
                  TextFormField(
                    controller: userController,
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Usuario o email',
                      hintText: "Usuario o email de la cuenta",
                    ),
                  ),
                  const SizedBox(height: 17.0),
                  _PasswordInput(passwordController: passwordController),
                  const SizedBox(height: 17.0),
                  TextFormField(
                    controller: urlController,
                    maxLines: 1,
                    maxLength: 1500,
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      counterText: '',
                      hintText: "URL del sitio web",
                      labelText: 'URL sitio web',
                    ),
                  ),
                  const SizedBox(height: 17.0),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 1,
                    maxLength: 1000,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      counterText: '',
                      hintText: "Descipción de la contraseña",
                      labelText: 'Descripción',
                    ),
                  ),
                  const SizedBox(height: 17.0),
                  TextFormField(
                    controller: notesController,
                    minLines: 1,
                    maxLines: 10,
                    maxLength: 1000,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      hintText: "Agregue notas a su contraseña",
                      labelText: 'Notas',
                    ),
                  ),
                  const SizedBox(height: 25.0),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: onPressed,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).buttonTheme.colorScheme?.primary,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              margin: const EdgeInsets.only(
                bottom: 5,
                left: 5,
                right: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.save),
                  SizedBox(width: 10.0),
                  Text(
                    'Guardar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
///
/// Input de password
///
////////////////////////////////////////////////////////////////////////////////
class _PasswordInput extends StatefulWidget {
  final TextEditingController passwordController;

  const _PasswordInput({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      maxLines: 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscurePassword,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: const Icon(Icons.remove_red_eye),
          onPressed: () {
            setState(() {
              obscurePassword = !obscurePassword;
            });
          },
        ),
        labelText: 'Contraseña',
        hintText: "Contraseña",
      ),
      validator: (_) => widget.passwordController.text.trim().isNotEmpty
          ? null
          : 'Contraseña requerida',
    );
  }
}
