import 'package:genesis_pt3/domain/Repositories/inventario/productos/producto_repository.dart';

class DeleteProductoUseCase {
  final ProductoRepository repository;
  DeleteProductoUseCase(this.repository);

  Future<void> call(String id) {
    return repository.deleteProducto(id);
  }
}