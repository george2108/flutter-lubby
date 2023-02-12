import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lubby_app/src/ui/widgets/show_snackbar_widget.dart';

import '../../../../data/entities/password_entity.dart';
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
      title: titleController.text.trim(),
      password: passwordController.text.trim(),
      user: userController.text.trim(),
      url: urlController.text.trim(),
      description: descriptionController.text.trim(),
      color: Colors.blue,
      favorite: false,
      notas: notesController.text.trim(),
      createdAt: DateTime.now(),
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
            TextFormField(
              controller: titleController,
              maxLines: 1,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
              decoration: const InputDecoration(
                labelText: 'Usuario',
                hintText: "Usuario de la cuenta",
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
