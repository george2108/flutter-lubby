import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injector.dart';
import '../../../../core/enums/type_labels.enum.dart';
import '../../repositories/password_repository.dart';
import '../bloc/passwords_bloc.dart';
import '../widgets/password_input_password_widget.dart';
import '../widgets/password_select_category_widget.dart';
import '../../../../ui/widgets/popup_options_widget.dart';
import '../../../../ui/widgets/custom_snackbar_widget.dart';
import '../../entities/password_entity.dart';
import '../../../../ui/widgets/select_icons_widget.dart';
import '../widgets/passwords_generate_password_widget.dart';

class PasswordView extends StatefulWidget {
  final String id;

  const PasswordView({super.key, required this.id});
  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  PasswordEntity password = PasswordEntity.empty();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool editing = false;
  bool loading = false;

  late final PasswordsBloc blocProvider;

  @override
  void initState() {
    super.initState();

    blocProvider = BlocProvider.of<PasswordsBloc>(context, listen: false);
    getData();
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

  Future<void> getData() async {
    if (widget.id != 'new') {
      setState(() {
        loading = true;
      });
      password = await injector<PasswordRepository>().getById(
        int.parse(widget.id),
      );

      editing = password.appId != null;

      titleController.text = password.title;
      passwordController.text = password.password;
      userController.text = password.userName ?? '';
      urlController.text = password.url ?? '';
      notesController.text = password.notas ?? '';
      descriptionController.text = password.description ?? '';

      setState(() {
        loading = false;
      });
    }
  }

  void onPressed() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    password = password.copyWith(
      title: titleController.text.trim(),
      password: passwordController.text.trim(),
      userName: userController.text.trim(),
      notas: notesController.text.trim(),
      description: descriptionController.text.trim(),
      url: urlController.text.trim(),
      createdAt: editing ? password.createdAt : DateTime.now(),
    );

    if (editing) {
      blocProvider.add(UpdatePasswordEvent(password));
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBarWidget(
          title: 'Contraseña actualizada',
          description: 'La contraseña se actualizó correctamente',
        ),
      );
      return;
    }

    blocProvider.add(CreatePasswordEvent(password));
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBarWidget(
        title: 'Contraseña creada',
        description: 'La contraseña se creó correctamente',
      ),
    );

    Navigator.of(context).pop();
  }

  _generatePassword() async {
    final passwordGenerated = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const PasswordsGeneratePasswordWidget(),
    );

    if (passwordGenerated != null) {
      passwordController.text = passwordGenerated;
    }
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
          if (!loading)
            PopupOptionsWidget(
              editing: editing,
              color: password.color,
              isFavorite: password.favorite,
              type: TypeLabels.passwords,
              colorMessage: 'Color de la contraseña',
              deleteMessageOption: 'Eliminar contraseña',
              labels: blocProvider.state.labels,
              labelSelected: password.label,
              onColorNoteChanged: (color) {
                setState(() {
                  password = password.copyWith(color: color);
                });
              },
              onFavoriteChanged: (favorite) {
                password = password.copyWith(favorite: favorite);
              },
              onLabelCreatedAndSelected: (labelSelectedOption) {
                blocProvider.add(AddLabelEvent(labelSelectedOption));
                setState(() {
                  password = password.copyWith(label: labelSelectedOption);
                });
              },
              onLabelSelected: (labelSelectedOption) {
                setState(() {
                  password = password.copyWith(
                    label: labelSelectedOption,
                    labelId: labelSelectedOption.appId,
                  );
                });
              },
            ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (password.appId == null && widget.id != 'new') {
            return const Center(
              child: Text('Contraseña no encontrada'),
            );
          }

          return _body(context);
        },
      ),
    );
  }

  Form _body(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: password.color,
                radius: 30.0,
                child: Icon(
                  password.icon,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              Column(
                children: [
                  ElevatedButton(
                    child: const Text('Cambiar icono'),
                    onPressed: () async {
                      final icon = await showDialog<IconData?>(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => const SelectIconsWidget(),
                      );

                      if (icon == null) return;

                      if (mounted) {
                        setState(() {
                          password = password.copyWith(icon: icon);
                        });
                      }
                    },
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
              prefixIcon: Icon(Icons.title),
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
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 17.0),
          PasswordInputPasswordWidget(passwordController: passwordController),
          GestureDetector(
            onTap: _generatePassword,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .buttonTheme
                    .colorScheme
                    ?.primary
                    .withOpacity(0.5),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              margin: const EdgeInsets.only(top: 5),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh),
                  SizedBox(width: 10.0),
                  Text(
                    'Generar contraseña',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
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
              prefixIcon: Icon(Icons.public),
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
              prefixIcon: Icon(Icons.description),
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
              prefixIcon: const Icon(Icons.note),
            ),
          ),
          const SizedBox(height: 25.0),
          PasswordSelectCategoryWidget(
            categorySelected: password.label,
            onCategorySelected: (category) {
              password = password.copyWith(
                label: category,
                labelId: category.appId,
              );
            },
          ),
        ],
      ),
    );
  }
}
