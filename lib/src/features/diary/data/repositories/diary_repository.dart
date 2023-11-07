import 'package:lubby_app/src/core/constants/db_tables_name_constants.dart';
import 'package:lubby_app/src/data/datasources/local/db/database_service.dart';

import 'package:lubby_app/src/features/diary/domain/entities/diary_entity.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/repositories/diary_repository_abstract.dart';

class DiaryRepository extends DiaryRepositoryAbstract {
  @override
  Future<int> addDiary(DiaryEntity diary) async {
    final db = await DatabaseProvider.db.database;

    return await db.insert(
      kDiaryTable,
      diary.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteDiary(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<DiaryEntity>> getDiariesOneDate(DateTime date) async {
    final db = await DatabaseProvider.db.database;
    final List<Map<String, dynamic>> diariesMaps = await db.query(kDiaryTable,
        // donde la fecha inicio y la fecha fin esten entre el dia seleccionado
        /* where: 'fechaInicio <= ? AND fechaFin >= ?',
      whereArgs: [date, date], */
        orderBy: 'startDate DESC');

    final diaries = List.generate(diariesMaps.length, (i) {
      return DiaryEntity.fromMap(diariesMaps[i]);
    });

    List<DiaryEntity> eventsInDate = [];
    for (var diary in diaries) {
      List<DateTime> dates = calcularFechasRepeticion(diary);
      for (var dateRepeat in dates) {
        if (DateTime(dateRepeat.year, dateRepeat.month, dateRepeat.day)
            .isAtSameMomentAs(DateTime(date.year, date.month, date.day))) {
          eventsInDate.add(diary);
          break;
        }
      }
    }

    return eventsInDate;
  }

  List<DateTime> calcularFechasRepeticion(DiaryEntity evento) {
    List<DateTime> fechasRepeticion = [];

    switch (evento.typeRepeat) {
      case 'daily':
        if (evento.endDate == null) {
          fechasRepeticion.add(evento.startDate);
        }

        for (var i = evento.startDate;
            i.isBefore(evento.endDate!);
            i = i.add(const Duration(days: 1)),) {
          fechasRepeticion.add(i);
        }
        break;

      case 'weekly':
        if (evento.endDate == null) {
          fechasRepeticion.add(evento.startDate);
        }

        for (var i = evento.startDate;
            i.isBefore(evento.endDate!);
            i = i.add(const Duration(days: 1))) {
          if (evento.daysRepeat.contains(getWeekDayNameByNumber(i.weekday))) {
            fechasRepeticion.add(i);
          }
        }
        break;

      case 'monthly':
        if (evento.endDate == null) {
          fechasRepeticion.add(evento.startDate);
        }

        for (var i = evento.startDate;
            i.isBefore(evento.endDate!);
            i = i.add(const Duration(days: 30))) {
          fechasRepeticion.add(i);
        }
        break;

      case 'yearly':
        if (evento.endDate == null) {
          fechasRepeticion.add(evento.startDate);
        }

        for (var i = evento.startDate;
            i.isBefore(evento.endDate!);
            i = i.add(const Duration(days: 365))) {
          fechasRepeticion.add(i);
        }
        break;
    }
    return fechasRepeticion;
  }

  getWeekDayNameByNumber(int weekday) {
    switch (weekday) {
      case 1:
        return 'Lunes';
      case 2:
        return 'Martes';
      case 3:
        return 'Miercoles';
      case 4:
        return 'Jueves';
      case 5:
        return 'Viernes';
      case 6:
        return 'Sabado';
      case 7:
        return 'Domingo';
      default:
        return 'Lunes';
    }
  }

  @override
  Future<DiaryEntity> getDiary(int id) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateDiary(DiaryEntity diary) {
    throw UnimplementedError();
  }
}
