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
  final password = IRoute(name: 'Password detail', path: '/password');

  // notes
  final notes = IRoute(name: 'Notes', path: '/notes');
  final note = IRoute(name: 'Note detail', path: '/note');

  // Tasks
  final toDos = IRoute(name: 'toDos', path: '/toDos');
  final toDo = IRoute(name: 'toDo', path: '/toDo');

// Activities
  final activities = IRoute(name: 'activities', path: '/activities');
  final activity = IRoute(name: 'activity', path: '/activity');

// Diary
  final diary = IRoute(name: 'diary', path: '/diary');

// Reminders
  final reminders = IRoute(name: 'reminders', path: '/reminders');
  final reminder = IRoute(name: 'reminder', path: '/reminder');

// Finances
  final finances = IRoute(name: 'finances', path: '/finances');
  final financesAccount =
      IRoute(name: 'financesAccount', path: '/finances/account');
  final financesNewAccountMovement = IRoute(
      name: 'financesNewAccountMovement',
      path: '/finances/new-account-movement');
  final financesNewAccount =
      IRoute(name: 'financesNewAccount', path: '/finances/new-account');
  final financesTransactionDetail = IRoute(
      name: 'financesTransactionDetail', path: '/finances/transaction-detail');

// QR Reader
  final qrReader = IRoute(name: 'qrReader', path: '/qr-reader');

// Habits
  final habits = IRoute(name: 'habits', path: '/habits');

// Configuration
  final config = IRoute(name: 'config', path: '/config');
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
