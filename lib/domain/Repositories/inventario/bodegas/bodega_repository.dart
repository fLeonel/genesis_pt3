import 'package:genesis_pt3/domain/Entities/inventario/bodegas/bodega_entity.dart';

abstract class BodegaRepository {
  Future<List<BodegaEntity>> getBodegas();
  Future<BodegaEntity> getBodegaById(String id);
  Future<void> createBodega(BodegaEntity bodega);
  Future<void> updateBodega(String id, Map<String, dynamic> data);
  Future<void> deleteBodega(String id);
}
