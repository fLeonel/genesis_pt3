import 'package:genesis_pt3/domain/Entities/inventario/recetas/receta_entity.dart';
import 'package:genesis_pt3/domain/Repositories/inventario/recetas/receta_repository.dart';

class CreateRecetaUseCase {
  final RecetaRepository repository;
  CreateRecetaUseCase(this.repository);

  Future<void> call(RecetaEntity receta) {
    return repository.createReceta(receta);
  }
}