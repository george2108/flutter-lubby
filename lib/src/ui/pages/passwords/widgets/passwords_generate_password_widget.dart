import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lubby_app/injector.dart';
import 'package:lubby_app/src/data/datasources/local/services/shared_preferences_service.dart';
import 'package:lubby_app/src/ui/widgets/copy_clipboard_widget.dart';
import 'package:lubby_app/src/ui/widgets/header_modal_bottom_widget.dart';

class PasswordsGeneratePasswordWidget extends StatefulWidget {
  const PasswordsGeneratePasswordWidget({super.key});

  @override
  State<PasswordsGeneratePasswordWidget> createState() =>
      _PasswordsGeneratePasswordWidgetState();
}

class _PasswordsGeneratePasswordWidgetState
    extends State<PasswordsGeneratePasswordWidget> {
  String password = '';

  final SharedPreferencesService sharedPreferencesService =
      injector.get<SharedPreferencesService>();

  late int passwordLength;
  late bool passwordUppercase;
  late bool passwordNumbers;
  late bool passwordSymbols;

  @override
  void initState() {
    super.initState();
    passwordLength = int.parse(sharedPreferencesService.passwordLength);
    passwordUppercase = sharedPreferencesService.passwordUppercase == 'yes';
    passwordNumbers = sharedPreferencesService.passwordNumbers == 'yes';
    passwordSymbols = sharedPreferencesService.passwordSymbols == 'yes';

    generatePassword();
  }

  generatePassword() {
    const String caracteresMinusculas = 'abcdefghijklmnopqrstuvwxyz';
    const String caracteresMayusculas = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String caracteresSimbolos = '!@#\$%^&*()_+-=[]{}|;:,.<>?';
    const String caracteresNumeros = '0123456789';

    final String caracteresPermitidos = caracteresMinusculas +
        (passwordUppercase ? caracteresMayusculas : '') +
        (passwordSymbols ? caracteresSimbolos : '') +
        (passwordNumbers ? caracteresNumeros : '');

    final Random random = Random();
    final StringBuffer contrasena = StringBuffer();

    for (int i = 0; i < passwordLength; i++) {
      final int indiceCaracter = random.nextInt(caracteresPermitidos.length);
      contrasena.write(caracteresPermitidos[indiceCaracter]);
    }
    setState(() {
      password = contrasena.toString();
    });
  }

  autocompletePassword() {
    Navigator.of(context).pop(password);
  }

  copyPassword() {
    copyClipboardWidget(password, 'Password', 'Password copied', context);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              HeaderModalBottomWidget(
                onCancel: () {
                  Navigator.of(context).pop();
                },
                onSave: () {},
                title: 'Generate Password',
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        password,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      clipBehavior: Clip.antiAlias,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: generatePassword,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Re-Generate'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          onPressed: copyPassword,
                          icon: const Icon(Icons.copy),
                          label: const Text('Copy'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          onPressed: autocompletePassword,
                          label: const Text('Autocomplete'),
                          icon: const Icon(Icons.autorenew),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Length'),
                        Text(passwordLength.toString()),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Slider.adaptive(
                      value: passwordLength.toDouble(),
                      min: 8,
                      max: 32,
                      divisions: 24,
                      onChanged: (value) {
                        setState(() {
                          passwordLength = value.toInt();
                        });
                      },
                      onChangeEnd: (value) {
                        sharedPreferencesService.passwordLength =
                            value.toInt().toString();
                        generatePassword();
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Include Symbols'),
                        Switch(
                          value: passwordSymbols,
                          onChanged: (value) {
                            setState(() {
                              passwordSymbols = value;
                              sharedPreferencesService.passwordSymbols =
                                  value ? 'yes' : 'no';
                            });
                            generatePassword();
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Include Numbers'),
                        Switch(
                          value: passwordNumbers,
                          onChanged: (value) {
                            setState(() {
                              passwordNumbers = value;
                              sharedPreferencesService.passwordNumbers =
                                  value ? 'yes' : 'no';
                            });
                            generatePassword();
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Include Uppercase'),
                        Switch(
                          value: passwordUppercase,
                          onChanged: (value) {
                            setState(() {
                              passwordUppercase = value;
                              sharedPreferencesService.passwordUppercase =
                                  value ? 'yes' : 'no';
                            });
                            generatePassword();
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
