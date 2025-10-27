import 'package:genesis_pt3/domain/Entities/inventario/bodegas/bodega_entity.dart';
import 'package:genesis_pt3/domain/Repositories/inventario/bodegas/bodega_repository.dart';

class GetBodegaByIdUseCase {
  final BodegaRepository repository;
  GetBodegaByIdUseCase(this.repository);

  Future<BodegaEntity> call(String id) {
    return repository.getBodegaById(id);
  }
}
