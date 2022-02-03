import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthProvider with ChangeNotifier {
  final localAuth = LocalAuthentication();

  List<BiometricType> availableBiometrics = [];

  bool hasFingerprintAuth = false;

  Future<bool> authenticate() async {
    final supported = await localAuth.isDeviceSupported();
    if (!supported) return false;

    bool canCheckBiometrics = await localAuth.canCheckBiometrics;
    if (!canCheckBiometrics) return false;

    availableBiometrics = await localAuth.getAvailableBiometrics();
    hasFingerprintAuth =
        availableBiometrics.contains(BiometricType.fingerprint);

    if (hasFingerprintAuth) {
      try {
        bool didAuthenticate = await localAuth.authenticate(
          localizedReason: 'Please authenticate to show account balance',
          stickyAuth: true,
        );
        return didAuthenticate;
      } on PlatformException catch (e) {
        canCheckBiometrics = false;
        print(e);
        return false;
      }
    }
    return false;
  }
}
