import 'package:genesis_pt3/domain/Entities/inventario/combos/combo_entity.dart';
import 'package:genesis_pt3/domain/Repositories/inventario/combos/combo_repository.dart';

class GetCombosUseCase {
  final ComboRepository repository;
  GetCombosUseCase(this.repository);

  Future<List<ComboEntity>> call() {
    return repository.getCombos();
  }
}