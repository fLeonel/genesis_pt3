import 'package:genesis_pt3/domain/Entities/inventario/recetas/receta_entity.dart';
import 'package:genesis_pt3/domain/Repositories/inventario/recetas/receta_repository.dart';
import 'package:genesis_pt3/infrastructure/http/api_client.dart';

class RecetaRepositoryImpl implements RecetaRepository {
  final ApiClient _api;

  RecetaRepositoryImpl(this._api);

  @override
  Future<List<RecetaEntity>> getRecetas() async {
    final response = await _api.get('/recetas');
    final List<dynamic> data = response.data;
    return data.map((e) => RecetaEntity.fromJson(e)).toList();
  }

  @override
  Future<RecetaEntity> getRecetaById(String id) async {
    final response = await _api.get('/recetas/$id');
    return RecetaEntity.fromJson(response.data);
  }

  @override
  Future<void> createReceta(RecetaEntity receta) async {
    await _api.post('/recetas', receta.toJson());
  }

  @override
  Future<void> updateReceta(String id, Map<String, dynamic> data) async {
    await _api.put('/recetas/$id', data);
  }

  @override
  Future<void> deleteReceta(String id) async {
    await _api.delete('/recetas/$id');
  }
}