import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/routes.dart';
import '../../../features/auth/presentation/bloc/auth_bloc.dart';

class HeaderMenuDrawerWidget extends StatelessWidget {
  const HeaderMenuDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: false);
    final authBlocListen = BlocProvider.of<AuthBloc>(context, listen: true);

    return Container(
      color: const Color(0xFF227c9d),
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.password),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications),
                      ),
                      PopupMenuButton(
                        child: const Icon(Icons.account_circle_outlined),
                        itemBuilder: (_) => [
                          const PopupMenuItem(child: Text('settings')),
                          const PopupMenuItem(
                            value: 'logOut',
                            child: Text('Cerrar sesión'),
                          ),
                        ],
                        onSelected: (value) async {
                          switch (value) {
                            case 'logOut':
                              final confirm = await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog.adaptive(
                                    contentPadding: const EdgeInsets.all(12.0),
                                    title: const Text('Cerrar sesión'),
                                    content: const Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('Esta seguro de cerrar sesión'),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancelar'),
                                      ),
                                      const SizedBox(width: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                        child: const Text('Si, cerrar sesión'),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (confirm == null) return;

                              authBloc.add(const AuthLogOutEvent());

                              break;
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.white,
              child: Text(
                'L',
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            if (authBloc.state.user?.email != null)
              Text(authBloc.state.user?.email ?? ''),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Text(
                'Tu asistente personal',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            if (!authBlocListen.state.authenticated)
              GestureDetector(
                onTap: () {
                  context.push(Routes().login.path);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  margin: const EdgeInsets.only(top: 10),
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                  child: const Text('iniciar sesión'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
