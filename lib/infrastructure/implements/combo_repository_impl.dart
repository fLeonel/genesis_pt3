import 'package:genesis_pt3/domain/Entities/inventario/combos/combo_entity.dart';
import 'package:genesis_pt3/domain/Repositories/inventario/combos/combo_repository.dart';
import 'package:genesis_pt3/infrastructure/http/api_client.dart';

class ComboRepositoryImpl implements ComboRepository {
  final ApiClient _api;

  ComboRepositoryImpl(this._api);

  @override
  Future<List<ComboEntity>> getCombos() async {
    final response = await _api.get('/combos');
    final List<dynamic> data = response.data;
    return data.map((e) => ComboEntity.fromJson(e)).toList();
  }

  @override
  Future<ComboEntity> getComboById(String id) async {
    final response = await _api.get('/combos/$id');
    return ComboEntity.fromJson(response.data);
  }

  @override
  Future<void> createCombo(ComboEntity combo) async {
    await _api.post('/combos', combo.toJson());
  }

  @override
  Future<void> updateCombo(String id, Map<String, dynamic> data) async {
    await _api.put('/combos/$id', data);
  }

  @override
  Future<void> deleteCombo(String id) async {
    await _api.delete('/combos/$id');
  }
}