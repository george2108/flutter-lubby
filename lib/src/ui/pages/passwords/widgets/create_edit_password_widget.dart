import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lubby_app/src/data/entities/password_entity.dart';
import 'package:lubby_app/src/ui/widgets/header_modal_bottom_widget.dart';

import '../bloc/passwords_bloc.dart';

class CreateEditPassword extends StatelessWidget {
  CreateEditPassword({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PasswordsBloc>(context);

    return Column(
      children: [
        HeaderModalBottomWidget(
          onCancel: () {},
          title: 'Nueva contraseña',
          onSave: () {
            if (formKey.currentState!.validate()) {
              return;
            }

            final password = PasswordEntity(
              title: titleController.text,
              password: passwordController.text,
              description: descriptionController.text,
              url: urlController.text,
              user: userController.text,
              notas: notesController.text,
              color: Colors.blue,
              favorite: false,
              createdAt: DateTime.now(),
            );

            bloc.add(CreatePasswordEvent(password));
          },
        ),
        Expanded(
          child: Scaffold(
            body: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(12),
              child: Form(
                key: formKey,
                child: Column(
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
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      maxLines: 1,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.remove_red_eye),
                          onPressed: () {},
                        ),
                        labelText: 'Contraseña',
                        hintText: "Contraseña",
                      ),
                      validator: (_) =>
                          passwordController.text.trim().isNotEmpty
                              ? null
                              : 'Contraseña requerida',
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: userController,
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Usuario',
                        hintText: "Usuario de la cuenta",
                      ),
                    ),
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 10),
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({
    Key? key,
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
            break;
          default:
            break;
        }
      },
    );
  }
}
