import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/enums/type_labels.enum.dart';
import '../../../labels/domain/entities/label_entity.dart';
import '../bloc/passwords_bloc.dart';
import '../widgets/password_input_password_widget.dart';
import '../widgets/password_select_category_widget.dart';
import '../widgets/passwords_generate_password_widget.dart';
import '../../../../ui/widgets/popup_options_widget.dart';
import '../../../../ui/widgets/custom_snackbar_widget.dart';
import '../../entities/password_entity.dart';
import '../../../../ui/widgets/select_icons_widget.dart';
import '../../../../ui/widgets/show_color_picker_widget.dart';

class PasswordView extends StatefulWidget {
  final String id;

  const PasswordView({super.key, required this.id});
  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  PasswordEntity passwordEntity = const PasswordEntity(
    title: '',
    password: '',
    favorite: false,
    color: Colors.blue,
    icon: Icons.add,
  );

  final TextEditingController titleController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool favorite = false;
  LabelEntity? labelSelected;
  IconData? iconSelected;
  Color colorSelected = kDefaultColorPick;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool editing = false;

  late final PasswordsBloc blocProvider;

  @override
  void initState() {
    super.initState();

    blocProvider = BlocProvider.of<PasswordsBloc>(context, listen: false);
    if (widget.id != 'new') {
      blocProvider.add(GetPasswordByIdEvent(id: int.parse(widget.id)));
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    passwordController.dispose();
    userController.dispose();
    urlController.dispose();
    notesController.dispose();
    descriptionController.dispose();

    blocProvider.add(ClearPasswordSelectedEvent());

    super.dispose();
  }

  void onPressed() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final password = PasswordEntity(
      appId: passwordEntity.appId,
      id: passwordEntity.id,
      title: titleController.text.trim(),
      password: passwordController.text.trim(),
      userName: userController.text.trim(),
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
          PopupOptionsWidget(
            editing: editing,
            color: colorSelected,
            isFavorite: favorite,
            type: TypeLabels.passwords,
            colorMessage: 'Color de la contraseña',
            deleteMessageOption: 'Eliminar contraseña',
            labels: blocProvider.state.labels,
            labelSelected: labelSelected,
            onColorNoteChanged: (color) {
              colorSelected = color;
            },
            onFavoriteChanged: (favorite) {
              this.favorite = favorite;
            },
            onLabelCreatedAndSelected: (labelSelectedOption) {
              labelSelected = labelSelectedOption;
              blocProvider.add(AddLabelEvent(labelSelectedOption));
            },
            onLabelSelected: (labelSelectedOption) {
              labelSelected = labelSelectedOption;
            },
          ),
        ],
      ),
      body: BlocBuilder<PasswordsBloc, PasswordsState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.passwordSelected.appId == null && widget.id != 'new') {
            return const Center(
              child: Text('Contraseña no encontrada'),
            );
          }

          final passwordState = state.passwordSelected;
          passwordEntity = passwordState;

          editing = passwordEntity.appId != null;
          favorite = passwordEntity.favorite;
          iconSelected = passwordEntity.icon;
          colorSelected = passwordEntity.color;
          labelSelected = passwordEntity.label;

          titleController.text = passwordEntity.title;
          passwordController.text = passwordEntity.password;
          userController.text = passwordEntity.userName ?? '';
          urlController.text = passwordEntity.url ?? '';
          notesController.text = passwordEntity.notas ?? '';
          descriptionController.text = passwordEntity.description ?? '';

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
                      final colorPicked = await pickColor.showDialogPickColor();
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
            categorySelected: labelSelected,
            onCategorySelected: (category) {
              labelSelected = category;
            },
          ),
        ],
      ),
    );
  }
}
