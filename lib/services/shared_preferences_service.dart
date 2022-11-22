import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new SharedPreferencesService();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...

*/

class SharedPreferencesService {
  static final SharedPreferencesService _instancia =
      SharedPreferencesService._internal();

  factory SharedPreferencesService() {
    return _instancia;
  }

  SharedPreferencesService._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del tema
  String get tema {
    return _prefs.getString('tema') ?? '';
  }

  set tema(String value) {
    _prefs.setString('tema', value);
  }

  // token
  String get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  // token
  String get user {
    return _prefs.getString('user') ?? '';
  }

  set user(String value) {
    _prefs.setString('user', value);
  }
}
