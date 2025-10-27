import 'package:genesis_pt3/domain/Repositories/inventario/recetas/receta_repository.dart';

class DeleteRecetaUseCase {
  final RecetaRepository repository;
  DeleteRecetaUseCase(this.repository);

  Future<void> call(String id) {
    return repository.deleteReceta(id);
  }
}