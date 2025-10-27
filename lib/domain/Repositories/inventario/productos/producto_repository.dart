import 'package:genesis_pt3/domain/Entities/inventario/productos/producto_entity.dart';

abstract class ProductoRepository {
  Future<List<ProductoEntity>> getProductos();
  Future<ProductoEntity> getProductoById(String id);
  Future<void> createProducto(ProductoEntity producto);
  Future<void> updateProducto(String id, Map<String, dynamic> data);
  Future<void> deleteProducto(String id);
}