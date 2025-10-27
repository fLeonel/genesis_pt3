import 'package:genesis_pt3/domain/Entities/inventario/combos/combo_entity.dart';
import 'package:genesis_pt3/domain/Repositories/inventario/combos/combo_repository.dart';

class GetComboByIdUseCase {
  final ComboRepository repository;
  GetComboByIdUseCase(this.repository);

  Future<ComboEntity> call(String id) {
    return repository.getComboById(id);
  }
}