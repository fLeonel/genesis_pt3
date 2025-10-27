import 'package:genesis_pt3/domain/Entities/inventario/combos/combo_entity.dart';
import 'package:genesis_pt3/domain/Repositories/inventario/combos/combo_repository.dart';

class CreateComboUseCase {
  final ComboRepository repository;
  CreateComboUseCase(this.repository);

  Future<void> call(ComboEntity combo) {
    return repository.createCombo(combo);
  }
}