import 'package:genesis_pt3/domain/Entities/inventario/productos/producto_entity.dart';
import 'package:genesis_pt3/domain/Repositories/inventario/productos/producto_repository.dart';
import 'package:genesis_pt3/infrastructure/http/api_client.dart';

class ProductoRepositoryImpl implements ProductoRepository {
  final ApiClient _api;

  ProductoRepositoryImpl(this._api);

  @override
  Future<List<ProductoEntity>> getProductos() async {
    final response = await _api.get('/productos');
    final List<dynamic> data = response.data;
    return data.map((e) => ProductoEntity.fromJson(e)).toList();
  }

  @override
  Future<ProductoEntity> getProductoById(String id) async {
    final response = await _api.get('/productos/$id');
    return ProductoEntity.fromJson(response.data);
  }

  @override
  Future<void> createProducto(ProductoEntity producto) async {
    await _api.post('/productos', producto.toJson());
  }

  @override
  Future<void> updateProducto(String id, Map<String, dynamic> data) async {
    await _api.put('/productos/$id', data);
  }

  @override
  Future<void> deleteProducto(String id) async {
    await _api.delete('/productos/$id');
  }
}