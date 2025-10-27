import 'package:genesis_pt3/domain/Entities/inventario/bodegas/bodega_entity.dart';
import 'package:genesis_pt3/domain/Repositories/inventario/bodegas/bodega_repository.dart';

class CreateBodegaUseCase {
  final BodegaRepository repository;
  CreateBodegaUseCase(this.repository);

  Future<void> call(BodegaEntity bodega) {
    return repository.createBodega(bodega);
  }
}
