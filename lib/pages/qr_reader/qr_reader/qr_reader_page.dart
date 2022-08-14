import 'package:flutter/material.dart';
import 'package:lubby_app/widgets/menu_drawer.dart';

class QRReaderPage extends StatelessWidget {
  const QRReaderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('lector de qr'),
      ),
      drawer: Menu(),
      body: const Center(
        child: Text('Este es un lector de qrs'),
      ),
    );
  }
}
