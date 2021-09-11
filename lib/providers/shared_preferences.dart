import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new SharedPreferencesProvider();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...

*/

class SharedPreferencesProvider {
  static final SharedPreferencesProvider _instancia =
      new SharedPreferencesProvider._internal();

  factory SharedPreferencesProvider() {
    return _instancia;
  }

  SharedPreferencesProvider._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del tema
  String get tema {
    return _prefs.getString('tema') ?? '';
  }

  set tema(String value) {
    _prefs.setString('tema', value);
  }
}
