import 'package:genesis_pt3/domain/Entities/inventario/combos/combo_entity.dart';

abstract class ComboRepository {
  Future<List<ComboEntity>> getCombos();
  Future<ComboEntity> getComboById(String id);
  Future<void> createCombo(ComboEntity combo);
  Future<void> updateCombo(String id, Map<String, dynamic> data);
  Future<void> deleteCombo(String id);
}