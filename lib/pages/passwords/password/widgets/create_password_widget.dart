part of '../password_page.dart';

class CreateOrUpdatePasswordWidget extends StatelessWidget {
  final _globalKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _userController;
  late final TextEditingController _passwordController;
  late final TextEditingController _descriptionController;

  final PasswordModel? password;

  CreateOrUpdatePasswordWidget({Key? key, this.password}) : super(key: key) {
    _titleController = TextEditingController(text: password?.title ?? '');
    _userController = TextEditingController(text: password?.user ?? '');
    _passwordController = TextEditingController(text: password?.password ?? '');
    _descriptionController =
        TextEditingController(text: password?.description ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordBloc, PasswordState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 8.0),
                  child: Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        _titlePassword(),
                        const SizedBox(height: 17.0),
                        _userPassword(),
                        const SizedBox(height: 17.0),
                        _password(),
                        const SizedBox(height: 17.0),
                        _description(),
                        const SizedBox(height: 17.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            _buttonLogin(context),
          ],
        );
      },
    );
  }

  Widget _description() {
    return TextFormField(
      controller: _descriptionController,
      maxLines: 1,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: "Descipción de la contraseña",
        labelText: 'Descripción',
        suffixIcon: _descriptionController.text.trim().length > 0
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _descriptionController.clear();
                },
              )
            : null,
      ),
    );
  }

  Widget _password() {
    return TextFormField(
      controller: _passwordController,
      maxLines: 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.visiblePassword,
      // obscureText: _passwordProvider.obscurePassword,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: const Icon(Icons.remove_red_eye),
          onPressed: () {
            // _passwordController.obscurePassword.toggle();
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: 'Contraseña',
        hintText: "Contraseña",
      ),
      validator: (_) {
        return _passwordController.text.trim().length > 0
            ? null
            : 'Contraseña requerida';
      },
    );
  }

  Widget _userPassword() {
    return TextFormField(
      controller: _userController,
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: 'Usuario',
        hintText: "Usuario de la cuenta",
        suffixIcon: _userController.text.trim().length > 0
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _userController.clear();
                },
              )
            : null,
      ),
    );
  }

  Widget _titlePassword() {
    return TextFormField(
      controller: _titleController,
      maxLines: 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: 'Titulo de la contraseña',
        labelText: 'Titulo',
        suffixIcon: _titleController.text.trim().length > 0
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _titleController.clear();
                },
              )
            : null,
      ),
      validator: (_) {
        return _titleController.text.trim().length > 0
            ? null
            : 'Titulo requerido';
      },
    );
  }

  _buttonLogin(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ArgonButton(
        height: 50,
        width: 350,
        child: const Text(
          'Guardar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        borderRadius: 5.0,
        color: Theme.of(context).buttonColor,
        loader: Container(
          padding: const EdgeInsets.all(10),
          child: const CircularProgressIndicator(
            backgroundColor: Colors.red,
          ),
        ),
        onTap: (startLoading, stopLoading, btnState) async {
          if (btnState == ButtonState.Idle) {
            startLoading();
            final passwordModel = PasswordModel(
              id: password?.id ?? null,
              title: _titleController.text.trim(),
              password: _passwordController.text.trim(),
              description: _descriptionController.text.trim(),
              user: _userController.text.trim(),
            );
            if (_globalKey.currentState!.validate()) {
              /* final respuesta = await provider.savePassword(passwordModel);
              if (respuesta) {
                Navigator.pop(context);
              } */
              final passwordProvider = BlocProvider.of<PasswordBloc>(context);
              final currentState = passwordProvider.state;
              if (currentState is PasswordLoadedState) {
                final editing = currentState.editing;
                if (editing) {
                  passwordProvider.add(UpdatedPasswordEvent(passwordModel));
                } else {
                  passwordProvider.add(CreatedPasswordEvent(passwordModel));
                }
                Navigator.of(context).pushAndRemoveUntil(
                    CupertinoPageRoute(
                      builder: (_) => PasswordsPage(),
                    ),
                    (route) => false);
              }
            }
            stopLoading();
            // navegar
          }
        },
      ),
    );
  }
}
