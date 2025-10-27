import 'package:genesis_pt3/domain/Repositories/inventario/bodegas/bodega_repository.dart';

class DeleteBodegaUseCase {
  final BodegaRepository repository;
  DeleteBodegaUseCase(this.repository);

  Future<void> call(String id) {
    return repository.deleteBodega(id);
  }
}
