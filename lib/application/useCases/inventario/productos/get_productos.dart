import 'package:genesis_pt3/domain/Entities/inventario/productos/producto_entity.dart';
import 'package:genesis_pt3/domain/Repositories/inventario/productos/producto_repository.dart';

class GetProductosUseCase {
  final ProductoRepository repository;
  GetProductosUseCase(this.repository);

  Future<List<ProductoEntity>> call() {
    return repository.getProductos();
  }
}