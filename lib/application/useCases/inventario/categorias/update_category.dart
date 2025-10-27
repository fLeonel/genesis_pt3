import 'package:genesis_pt3/domain/Entities/inventario/categorias/categoria_entity.dart';
import 'package:genesis_pt3/domain/Repositories/inventario/categorias/categoria_repository.dart';

class UpdateCategoriaUseCase {
  final CategoriaRepository repository;
  UpdateCategoriaUseCase(this.repository);

  Future<void> call(CategoriaEntity categoria) async {
    await repository.updateCategoria(categoria);
  }
}
