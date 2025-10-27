import 'package:genesis_pt3/domain/Entities/inventario/productos/producto_entity.dart';
import 'package:genesis_pt3/domain/Repositories/inventario/productos/producto_repository.dart';

class CreateProductoUseCase {
  final ProductoRepository repository;
  CreateProductoUseCase(this.repository);

  Future<void> call(ProductoEntity producto) {
    return repository.createProducto(producto);
  }
}