import 'package:genesis_pt3/domain/Repositories/inventario/recetas/receta_repository.dart';

class UpdateRecetaUseCase {
  final RecetaRepository repository;
  UpdateRecetaUseCase(this.repository);

  Future<void> call(String id, Map<String, dynamic> data) {
    return repository.updateReceta(id, data);
  }
}