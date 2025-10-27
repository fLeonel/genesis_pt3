import 'package:genesis_pt3/domain/Entities/inventario/bodegas/bodega_entity.dart';
import 'package:genesis_pt3/domain/Repositories/inventario/bodegas/bodega_repository.dart';

class GetBodegasUseCase {
  final BodegaRepository repository;
  GetBodegasUseCase(this.repository);

  Future<List<BodegaEntity>> call() {
    return repository.getBodegas();
  }
}
