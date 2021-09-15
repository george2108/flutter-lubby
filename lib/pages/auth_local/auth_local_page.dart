import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:lubby_app/pages/auth_local/auth_local_controller.dart';
import 'package:lubby_app/widgets/show_snackbar_widget.dart';

class AuthLocalPage extends StatefulWidget {
  @override
  _AuthLocalPageState createState() => _AuthLocalPageState();
}

class _AuthLocalPageState extends State<AuthLocalPage>
    with TickerProviderStateMixin {
  final _authController = Get.find<AuthLocalController>();

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Get.back();
        Get.offNamedUntil('/passwords', (route) => false);
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
      body: SingleChildScrollView(
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
              margin: EdgeInsets.all(15),
              child: Text(
                'Bienvenido',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.headline6!.fontSize,
                ),
              ),
            ),
            Container(
              width: size.width * 0.6,
              child: Lottie.asset('assets/security.json'),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Text(
                'Necesitas autenticarte para iniciar sesión.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.headline6!.fontSize,
                ),
              ),
            ),
            ArgonButton(
              height: 50,
              width: 350,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.fingerprint),
                  Text(
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
                padding: EdgeInsets.all(10),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ),
              ),
              onTap: (startLoading, stopLoading, btnState) async {
                if (btnState == ButtonState.Idle) {
                  startLoading();
                  final auth = await _authController.authenticate();
                  if (auth) {
                    Get.defaultDialog(
                      content: Lottie.asset(
                        'assets/fingerprint.json',
                        repeat: false,
                        controller: _controller,
                        onLoaded: (composition) {
                          _controller.forward();
                        },
                      ),
                    );
                  } else {
                    showSnackBarWidget(
                      title: 'Algo salió mal',
                      message: 'No se pudo realizar la autenticación',
                    );
                  }
                  stopLoading();
                  // navegar
                }
              },
            ),
          ],
        ),
      ),
    );
  }
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
