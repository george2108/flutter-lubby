import 'db_tables_name_constants.dart';

const List<String> kDBDDL = [
  // Tabla de etiquetas
  '''
      CREATE TABLE $kLabelsTable(
        appId INTEGER PRIMARY KEY AUTOINCREMENT,
        id INTEGER NULL,
        name TEXT NOT NULL,
        icon TEXT NOT NULL,
        color INT NOT NULL,
        type VARCHAR(150) NOT NULL,
        createdAt TIMESTAMP
      )
      ''',
  // Tabla de notas
  '''
      CREATE TABLE $kNotesTable(
        appId INTEGER PRIMARY KEY AUTOINCREMENT,
        id INTEGER NULL,
        title TEXT,
        body TEXT,
        createdAt TIMESTAMP,
        favorite INTEGER(1) DEFAULT 0,
        color INT NOT NULL,
        labelId INTEGER NULL,
        FOREIGN KEY (labelId) REFERENCES $kLabelsTable(id)
      )
      ''',
  // Tabla de contraseñas
  '''
      CREATE TABLE $kPasswordsTable(
        appId INTEGER PRIMARY KEY AUTOINCREMENT,
        id INTEGER NULL,
        title TEXT NULL,
        userName TEXT NULL,
        password TEXT,
        description TEXT NULL,
        createdAt TIMESTAMP,
        favorite INTEGER(1) DEFAULT 0,
        url TEXT NULL,
        notas TEXT NULL,
        color INT NOT NULL,
        icon TEXT NOT NULL,
        labelId INTEGER NULL,
        FOREIGN KEY (labelId) REFERENCES $kLabelsTable(id)
      )
      ''',
  // Tabla de cuentas bancarias o de efectivo
  '''
      CREATE TABLE $kAccountsTable(
        appId INTEGER PRIMARY KEY AUTOINCREMENT,
        id INTEGER NULL,
        name TEXT NOT NULL,
        description TEXT NULL,
        balance REAL NOT NULL,
        createdAt TIMESTAMP,
        icon TEXT NOT NULL,
        color INT NOT NULL
      )
      ''',
  // Tabla de transacciones
  '''
      CREATE TABLE $kTransactionsTable(
        appId INTEGER PRIMARY KEY AUTOINCREMENT,
        id INTEGER NULL,
        accountId INTEGER NOT NULL,
        accountDestId INTEGER NULL,
        title TEXT NOT NULL,
        description TEXT NULL,
        amount REAL NOT NULL,
        createdAt TIMESTAMP,
        labelId INTEGER NULL,
        type VARCHAR(20) NOT NULL,
        FOREIGN KEY (accountId) REFERENCES $kAccountsTable(id),
        FOREIGN KEY (accountDestId) REFERENCES $kAccountsTable(id),
        FOREIGN KEY (labelId) REFERENCES $kLabelsTable(id)
      )
      ''',
  // Tabla de lista de tareas
  '''
      CREATE TABLE $kTodosTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title VARCHAR(50) NOT NULL,
        description TEXT NULL,
        complete INTEGER DEFAULT 0,
        createdAt TIMESTAMP,
        favorite INTEGER(1) DEFAULT 0,
        totalItems INTEGER DEFAULT 0,
        percentCompleted INTEGER DEFAULT 0,
        color INT NOT NULL
      )
      ''',
  // Tabla de detalle de lista de tareas
  '''
      CREATE TABLE $kTodosDetailTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        toDoId int NULL,
        title VARCHAR(100) NOT NULL,
        description TEXT NULL,
        startDate DATE NULL,
        startTime TIME NULL,
        complete INTEGER(1) DEFAULT 0,
        orderDetail INTEGER NULL,
        FOREIGN KEY (toDoId) REFERENCES $kTodosTable(id)
      )
      ''',
  // Tabla de estado de detalle de lista de tareas
  '''
      CREATE TABLE $kTodosDetailStateTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        toDoDetailId INT NULL,
        dateAffected DATE NULL,
        timeAffected TIME NULL,
        complete INTEGER(1) DEFAULT 0,
        FOREIGN KEY (toDoDetailId) REFERENCES $kTodosDetailTable(id)
      )
      ''',
  // Tabla de eventos de agenda
  '''
      CREATE TABLE $kDiaryTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        startDate TIMESTAMP,
        endDate TIMESTAMP NULL,
        startTime TIME NULL,
        endTime TIME NULL,
        labelId INTEGER NULL,
        color INT NOT NULL,
        typeRepeat VARCHAR(20) NOT NULL,
        daysRepeat VARCHAR(200) NOT NULL,
        FOREIGN KEY (labelId) REFERENCES $kLabelsTable(id)
      )
      ''',
  // Tabla de actividades
  '''
      CREATE TABLE $kActivitiesTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NULL,
        createdAt TIMESTAMP,
        favorite INTEGER(1) DEFAULT 0
      )
      ''',
  // tabla de listas de actividades
  '''
      CREATE TABLE $kActivitiesListsTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NULL,
        createdAt TIMESTAMP,
        orderDetail INTEGER NULL,
        activityId int NOT NULL,
        FOREIGN KEY (activityId) REFERENCES $kActivitiesTable(id)
      )
      ''',
  // tabla de tarjetas de actividades
  '''
      CREATE TABLE $kActivitiesCardsTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NULL,
        description TEXT NULL,
        color INT NOT NULL,
        createdAt TIMESTAMP,
        dateLimit TIMESTAMP,
        orderDetail INTEGER NULL,
        acitvityListId int NOT NULL,
        FOREIGN KEY (acitvityListId) REFERENCES $kActivitiesListsTable(id)
      )
      ''',
];
