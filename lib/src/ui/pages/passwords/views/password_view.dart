import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lubby_app/src/data/entities/label_entity.dart';
import 'package:lubby_app/src/ui/widgets/select_label_widget.dart';
import 'package:lubby_app/src/ui/widgets/show_snackbar_widget.dart';
import 'package:lubby_app/src/ui/widgets/star_favorite_widget.dart';

import '../../../../data/entities/password_entity.dart';
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
  Color? colorSelected;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool editing = false;

  @override
  void initState() {
    editing = widget.password != null;

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

    favorite = widget.password?.favorite ?? false;

    iconSelected = widget.password?.icon ?? Icons.lock;
    colorSelected = widget.password?.color ?? Colors.blue;

    // TODO: IMPLEMENTAR LABELS
    labelSelected = widget.password?.label;

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
      color: colorSelected!,
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
        showCustomSnackBarWidget(
          title: 'Contraseña actualizada',
          content: 'La contraseña se actualizó correctamente',
        ),
      );
      return;
    }

    bloc.add(CreatePasswordEvent(password));
    ScaffoldMessenger.of(context).showSnackBar(
      showCustomSnackBarWidget(
        title: 'Contraseña creada',
        content: 'La contraseña se creó correctamente',
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final blocListening = BlocProvider.of<PasswordsBloc>(
      widget.passwordContext,
      listen: true,
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
          _PopupMenu(editing: editing),
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StarFavoriteWidget(
                    valueInitial: favorite,
                    onStarPressed: (value) {
                      favorite = value;
                    },
                  ),
                  const SizedBox(width: 10.0),
                  SelectLabelWidget(
                    labels: blocListening.state.labels,
                    labelSelected: labelSelected,
                    onSelected: (labelSelected) {
                      setState(() {
                        this.labelSelected = labelSelected;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
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
    );
  }
}

///////////////////////// WIDGETS //////////////////////////////////////////////
///
/// Widget para mostrar el popup menu
///
////////////////////////////////////////////////////////////////////////////////
class _PopupMenu extends StatelessWidget {
  final bool editing;

  const _PopupMenu({
    Key? key,
    required this.editing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (_) => [
        PopupMenuItem(
          value: 'color',
          child: Row(
            children: const [
              Icon(Icons.color_lens_outlined),
              SizedBox(width: 5),
              Text(
                'Color de contraseña',
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'ayuda',
          child: Row(
            children: const [
              Icon(Icons.help_outline),
              SizedBox(width: 5),
              Text('Ayuda', textAlign: TextAlign.start),
            ],
          ),
        ),
        if (editing)
          PopupMenuItem(
            value: 'eliminar',
            child: Row(
              children: const [
                Icon(Icons.delete_outline),
                SizedBox(width: 5),
                Text('Eliminar contraseña'),
              ],
            ),
          ),
      ],
      onSelected: (value) async {
        switch (value) {
          case 'color':
            final pickColor = ShowColorPickerWidget(
              context: context,
              color: Colors.black,
            );
            final colorPicked = await pickColor.showDialogPickColor();
            if (colorPicked != null) {
              // bloc.add(PasswordChangeColorEvent(colorPicked));
            }
            break;
          default:
            break;
        }
      },
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
