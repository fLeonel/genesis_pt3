import 'package:genesis_pt3/domain/Entities/inventario/recetas/receta_entity.dart';
import 'package:genesis_pt3/domain/Repositories/inventario/recetas/receta_repository.dart';

class GetRecetaByIdUseCase {
  final RecetaRepository repository;
  GetRecetaByIdUseCase(this.repository);

  Future<RecetaEntity> call(String id) {
    return repository.getRecetaById(id);
  }
}