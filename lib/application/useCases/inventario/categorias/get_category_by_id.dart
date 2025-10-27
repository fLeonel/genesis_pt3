import 'package:genesis_pt3/domain/Entities/inventario/categorias/categoria_entity.dart';
import 'package:genesis_pt3/domain/Repositories/inventario/categorias/categoria_repository.dart';

class GetCategoriaByIdUseCase {
  final CategoriaRepository repository;
  GetCategoriaByIdUseCase(this.repository);

  Future<CategoriaEntity> call(String id) async {
    return await repository.getCategoriaById(id);
  }
}
