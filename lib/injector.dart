import 'package:get_it/get_it.dart';

import 'src/data/datasources/local/services/local_notifications_service.dart';
import 'src/data/datasources/local/services/password_service.dart';
import 'src/data/datasources/local/services/shared_preferences_service.dart';
import 'src/data/datasources/remote/http_service.dart';
import 'src/data/repositories/base_http_repository.dart';
import 'src/features/auth/data/repositories/login_repository.dart';
import 'src/features/auth/data/repositories/register_repository.dart';
import 'src/features/diary/data/repositories/diary_repository.dart';
import 'src/features/finances/data/repositories/finances_repository.dart';
import 'src/features/labels/data/repositories/label_repository.dart';
import 'src/features/notes/data/repositories/note_repository.dart';
import 'src/features/passwords/data/repositories/password_repository.dart';
import 'src/features/todos/data/repositories/todo_repository.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  // services
  injector.registerSingleton<SharedPreferencesService>(
    SharedPreferencesService(),
  );
  injector.registerLazySingleton(() => HttpService());
  injector.registerSingleton<PasswordService>(PasswordService());
  injector.registerSingleton<LocalNotificationsService>(
    LocalNotificationsService(),
  );

  // repositories
  injector.registerLazySingleton(() => BaseHttpRepository);

  injector.registerSingleton(RegisterRepository(
    httpService: injector<HttpService>(),
  ));
  injector.registerSingleton<LoginRepository>(LoginRepository(
    httpService: injector<HttpService>(),
  ));
  injector.registerSingleton<LabelRepository>(LabelRepository(
    httpService: injector<HttpService>(),
  ));
  injector.registerSingleton<NoteRepository>(NoteRepository());
  injector.registerSingleton<FinancesRepository>(FinancesRepository());
  injector.registerSingleton<DiaryRepository>(DiaryRepository());
  injector.registerSingleton<PasswordRepository>(PasswordRepository(
    httpService: injector<HttpService>(),
  ));
  injector.registerSingleton<TodoRepository>(TodoRepository());
}
