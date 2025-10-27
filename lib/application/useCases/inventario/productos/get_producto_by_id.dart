import 'package:genesis_pt3/domain/Entities/inventario/productos/producto_entity.dart';
import 'package:genesis_pt3/domain/Repositories/inventario/productos/producto_repository.dart';

class GetProductoByIdUseCase {
  final ProductoRepository repository;
  GetProductoByIdUseCase(this.repository);

  Future<ProductoEntity> call(String id) {
    return repository.getProductoById(id);
  }
}