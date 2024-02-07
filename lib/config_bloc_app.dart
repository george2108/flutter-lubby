import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injector.dart';
import 'my_app.dart';
import 'src/data/datasources/local/shared_preferences_service.dart';
import 'src/features/auth/presentation/bloc/auth_bloc.dart';
import 'src/features/auth/repositories/login_repository.dart';
import 'src/features/auth/repositories/register_repository.dart';
import 'src/features/labels/data/repositories/label_repository.dart';
import 'src/features/notes/repositories/note_repository.dart';
import 'src/features/notes/presentation/bloc/notes_bloc.dart';
import 'src/features/passwords/presentation/bloc/passwords_bloc.dart';
import 'src/features/passwords/repositories/password_repository.dart';
import 'src/ui/bloc/config/config_bloc.dart';
import 'src/ui/bloc/global/global_bloc.dart';
import 'src/ui/bloc/navigation/navigation_bloc.dart';
import 'src/ui/bloc/theme/theme_bloc.dart';

class ConfigBlocApp extends StatelessWidget {
  const ConfigBlocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => AuthBloc(
            loginRepository: injector<LoginRepository>(),
            registerRepository: injector<RegisterRepository>(),
            sharedPreferencesService: injector<SharedPreferencesService>(),
          )..add(
              const AuthCheckEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(injector<SharedPreferencesService>()),
        ),
        BlocProvider(create: (context) => ConfigBloc()),
        BlocProvider(create: (context) => GlobalBloc()),
        BlocProvider(create: (context) => NavigationBloc()),
        BlocProvider(
          lazy: true,
          create: (context) => PasswordsBloc(
            injector<PasswordRepository>(),
            injector<LabelRepository>(),
          ),
        ),
        BlocProvider(
          lazy: true,
          create: (context) => NotesBloc(
            injector<NoteRepository>(),
            injector<LabelRepository>(),
          ),
        ),
      ],
      child: const MyApp(),
    );
  }
}
