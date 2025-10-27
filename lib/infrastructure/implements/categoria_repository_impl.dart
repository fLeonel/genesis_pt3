import 'package:genesis_pt3/domain/Entities/inventario/categorias/categoria_entity.dart';
import 'package:genesis_pt3/domain/Repositories/inventario/categorias/categoria_repository.dart';
import 'package:genesis_pt3/infrastructure/http/api_client.dart';

class CategoriaRepositoryImpl implements CategoriaRepository {
  final ApiClient api;

  CategoriaRepositoryImpl(this.api);

  @override
  Future<List<CategoriaEntity>> getCategorias() async {
    final res = await api.get('/categorias');
    final data = res.data as List;
    return data
        .map(
          (e) => CategoriaEntity(
            id: e['id'],
            nombre: e['nombre'],
            descripcion: e['descripcion'],
          ),
        )
        .toList();
  }

  @override
  Future<CategoriaEntity> getCategoriaById(String id) async {
    final res = await api.get('/categorias/$id');
    final e = res.data;
    return CategoriaEntity(
      id: e['id'],
      nombre: e['nombre'],
      descripcion: e['descripcion'],
    );
  }

  @override
  Future<void> createCategoria(CategoriaEntity categoria) async {
    await api.post('/categorias', {
      'nombre': categoria.nombre,
      'descripcion': categoria.descripcion,
    });
  }

  @override
  Future<void> updateCategoria(String id, Map<String, dynamic> data) async {
    await api.put('/categorias/$id', data);
  }

  @override
  Future<void> deleteCategoria(String id) async {
    await api.delete('/categorias/$id');
  }
}
