import 'package:genesis_pt3/domain/Repositories/inventario/categorias/categoria_repository.dart';

class UpdateCategoriaUseCase {
  final CategoriaRepository repository;
  UpdateCategoriaUseCase(this.repository);

  Future<void> call(String id, Map<String, dynamic> data) {
    return repository.updateCategoria(id, data);
  }
}
