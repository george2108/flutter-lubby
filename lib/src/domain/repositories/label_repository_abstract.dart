import '../../core/enums/type_labels.enum.dart';
import '../entities/label_entity.dart';

abstract class LabelRepositoryAbstract {
  Future<void> addNewLabel(LabelEntity label);

  Future<int> deleteLabel(int id);

  Future<List<LabelEntity>> getLabels(TypeLabels type);

  Future<List<LabelEntity>> searchLabel(String term);

  Future<int> updateLabel(LabelEntity label);

  Future<LabelEntity> getLabelById(int id);
}
