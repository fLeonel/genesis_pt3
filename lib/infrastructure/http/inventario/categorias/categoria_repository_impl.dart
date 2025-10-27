import 'package:genesis_pt3/domain/Entities/inventario/categorias/categoria_entity.dart';

abstract class CategoriaRepository {
  Future<List<CategoriaEntity>> getCategorias();
  Future<void> createCategoria(CategoriaEntity categoria);
  Future<void> updateCategoria(CategoriaEntity categoria);
  Future<void> deleteCategoria(String id);
}
