import 'package:genesis_pt3/domain/Entities/inventario/categorias/categoria_entity.dart';

abstract class CategoriaRepository {
  Future<List<CategoriaEntity>> getCategorias();
  Future<CategoriaEntity> getCategoriaById(String id);
  Future<void> createCategoria(CategoriaEntity categoria);
  Future<void> updateCategoria(String id, Map<String, dynamic> data);
  Future<void> deleteCategoria(String id);
}
