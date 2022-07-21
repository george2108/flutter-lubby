import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:lubby_app/pages/auth_local/bloc/auth_local_bloc.dart';
import 'package:lubby_app/pages/passwords/passwords/passwords_page.dart';

class AuthLocalPage extends StatefulWidget {
  @override
  _AuthLocalPageState createState() => _AuthLocalPageState();
}

class _AuthLocalPageState extends State<AuthLocalPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        _controller.reset();
        Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => PasswordsPage()),
          (route) => false,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthLocalBloc(),
        child: BlocConsumer<AuthLocalBloc, AuthLocalState>(
          listener: (context, state) {
            if (state.authenticated) {
              this.showLoggedDialog();
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ClipPath(
                    clipper: RoundShape(3),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      color: Theme.of(context).accentColor,
                      alignment: Alignment.center,
                      child: SafeArea(
                        child: Text(
                          'LUBBY',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: Text(
                      'Bienvenido',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:
                            Theme.of(context).textTheme.headline6!.fontSize,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.6,
                    child: Lottie.asset('assets/security.json'),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: Text(
                      'Necesitas autenticarte para iniciar sesión.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:
                            Theme.of(context).textTheme.headline6!.fontSize,
                      ),
                    ),
                  ),
                  ArgonButton(
                    height: 50,
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.fingerprint),
                        const Text(
                          'Autenticarme',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ],
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
                        BlocProvider.of<AuthLocalBloc>(context).add(
                          CheckAuthenticatedEvent(),
                        );
                        stopLoading();
                        // navegar
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  showLoggedDialog() => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Dialog(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/fingerprint.json',
                repeat: false,
                controller: _controller,
                onLoaded: (composition) {
                  _controller.forward();
                },
              ),
              const Text('Autenticado.'),
              const Text('Redireccionando a la pagina de inicio.'),
            ],
          ),
        ),
      );
}

class RoundShape extends CustomClipper<Path> {
  final proportionalSize;

  RoundShape(this.proportionalSize);

  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    double curveHeight = size.height / proportionalSize;
    var p = Path();
    p.lineTo(0, height - curveHeight);
    p.quadraticBezierTo(width / 2, height, width, height - curveHeight);
    p.lineTo(width, 0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
