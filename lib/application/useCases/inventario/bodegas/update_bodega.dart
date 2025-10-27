import 'package:genesis_pt3/domain/Repositories/inventario/bodegas/bodega_repository.dart';

class UpdateBodegaUseCase {
  final BodegaRepository repository;
  UpdateBodegaUseCase(this.repository);

  Future<void> call(String id, Map<String, dynamic> data) {
    return repository.updateBodega(id, data);
  }
}
