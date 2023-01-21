import 'package:get_it/get_it.dart';
import 'package:lubby_app/src/data/datasources/local/services/local_notifications_service.dart';
import 'package:lubby_app/src/data/datasources/local/services/password_service.dart';
import 'package:lubby_app/src/data/datasources/local/services/shared_preferences_service.dart';
import 'package:lubby_app/src/data/repositories/finances_repository.dart';
import 'package:lubby_app/src/data/repositories/label_repository.dart';
import 'package:lubby_app/src/data/repositories/note_repository.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  // services
  injector.registerSingleton<SharedPreferencesService>(
    SharedPreferencesService(),
  );
  injector.registerSingleton<PasswordService>(PasswordService());
  injector.registerSingleton<LocalNotificationsService>(
    LocalNotificationsService(),
  );

  // repositories
  injector.registerSingleton<LabelRepository>(LabelRepository());
  injector.registerSingleton<NoteRepository>(NoteRepository());
  injector.registerSingleton<FinancesRepository>(FinancesRepository());
}
