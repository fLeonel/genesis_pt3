import 'package:genesis_pt3/domain/Entities/inventario/recetas/receta_entity.dart';
import 'package:genesis_pt3/domain/Repositories/inventario/recetas/receta_repository.dart';

class GetRecetasUseCase {
  final RecetaRepository repository;
  GetRecetasUseCase(this.repository);

  Future<List<RecetaEntity>> call() {
    return repository.getRecetas();
  }
}