import 'package:lubby_app/src/data/entities/diary_entity.dart';

abstract class DiaryRepositoryAbstract {
  Future<List<DiaryEntity>> getDiariesOneDate(DateTime date);

  Future<DiaryEntity> getDiary(int id);

  Future<void> addDiary(DiaryEntity diary);

  Future<void> updateDiary(DiaryEntity diary);

  Future<void> deleteDiary(int id);
}
