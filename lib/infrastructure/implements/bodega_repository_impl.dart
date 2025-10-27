import 'package:genesis_pt3/domain/Entities/inventario/bodegas/bodega_entity.dart';
import 'package:genesis_pt3/domain/Repositories/inventario/bodegas/bodega_repository.dart';
import 'package:genesis_pt3/infrastructure/http/api_client.dart';

class BodegaRepositoryImpl implements BodegaRepository {
  final ApiClient _api;

  BodegaRepositoryImpl(this._api);

  @override
  Future<List<BodegaEntity>> getBodegas() async {
    final response = await _api.get('/api/bodegas');
    final List<dynamic> data = response.data;
    return data.map((e) => BodegaEntity.fromJson(e)).toList();
  }

  @override
  Future<BodegaEntity> getBodegaById(String id) async {
    final response = await _api.get('/api/bodegas/$id');
    return BodegaEntity.fromJson(response.data);
  }

  @override
  Future<void> createBodega(BodegaEntity bodega) async {
    await _api.post('/api/bodegas', bodega.toJson()); // ✅ corregido
  }

  @override
  Future<void> updateBodega(String id, Map<String, dynamic> data) async {
    await _api.put('/api/bodegas/$id', data); // ✅ corregido
  }

  @override
  Future<void> deleteBodega(String id) async {
    await _api.delete('/api/bodegas/$id');
  }
}
