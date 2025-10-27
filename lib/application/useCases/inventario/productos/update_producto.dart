import 'package:genesis_pt3/domain/Repositories/inventario/productos/producto_repository.dart';

class UpdateProductoUseCase {
  final ProductoRepository repository;
  UpdateProductoUseCase(this.repository);

  Future<void> call(String id, Map<String, dynamic> data) {
    return repository.updateProducto(id, data);
  }
}