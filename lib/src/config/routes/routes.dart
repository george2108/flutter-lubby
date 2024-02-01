class IRoute {
  final String name;
  final String path;

  IRoute({required this.name, required this.path});
}

class Routes {
  static final Routes _singleton = Routes._();
  Routes._();
  factory Routes() {
    return _singleton;
  }

  // auth
  final login = IRoute(name: 'Login', path: '/login');
  final register = IRoute(name: 'Register', path: '/register');

  // passwords
  final passwords = IRoute(name: 'Passwords', path: '/passwords');

  // notes
  final notes = IRoute(name: 'Notes', path: '/notes');
}

// auth
const String loginRoute = '/login';
const String registerRoute = '/register';

// Passwords
const String passwordsRoute = '/passwords';
const String passwordRoute = '/password';

// Notes
const String notesRoute = '/notes';
const String noteRoute = '/note';

// Tasks
const String toDosRoute = '/toDos';
const String toDoRoute = '/toDo';

// Activities
const String activitiesRoute = '/activities';
const String activityRoute = '/activity';

// Diary
const String diaryRoute = '/diary';

// Reminders
const String remindersRoute = '/reminders';
const String reminderRoute = '/reminder';

// Finances
const String financesRoute = '/finances';
const String financesAccountRoute = '/finances/account';
const String financesNewAccountMovementRoute = '/finances/new-account-movement';
const String financesNewAccountRoute = '/finances/new-account';
const String financesTransactionDetailRoute = '/finances/transaction-detail';

// QR Reader
const String qrReaderRoute = '/qr-reader';

// Habits
const String habitsRoute = '/habits';

// Configuration
const String configRoute = '/config';
