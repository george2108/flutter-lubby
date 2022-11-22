import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

part 'auth_local_event.dart';
part 'auth_local_state.dart';

class AuthLocalBloc extends Bloc<AuthLocalEvent, AuthLocalState> {
  AuthLocalBloc() : super(AuthLocalInitialState(false)) {
    on<CheckAuthenticatedEvent>(authenticateUser);
  }

  void authenticateUser(
    AuthLocalEvent event,
    Emitter<AuthLocalState> emit,
  ) async {
    final localAuth = LocalAuthentication();

    final supported = await localAuth.isDeviceSupported();
    if (!supported) {
      emit(AuthLocalInitialState(false));
      return;
    }

    bool canCheckBiometrics = await localAuth.canCheckBiometrics;
    if (!canCheckBiometrics) {
      emit(AuthLocalInitialState(false));
      return;
    }

    List<BiometricType> availableBiometrics =
        await localAuth.getAvailableBiometrics();

    final bool hasFingerprintAuth =
        availableBiometrics.contains(BiometricType.fingerprint) ||
            availableBiometrics.contains(BiometricType.strong);

    if (!hasFingerprintAuth) {
      emit(AuthLocalInitialState(false));
      return;
    }

    try {
      bool didAuthenticate = await localAuth.authenticate(
        localizedReason: 'Please authenticate to show account balance',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
          useErrorDialogs: true,
        ),
      );
      emit(AuthLocalInitialState(didAuthenticate));
      return;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
      emit(AuthLocalInitialState(false));
      return;
    }
  }
}
