import 'package:genesis_pt3/domain/Repositories/inventario/combos/combo_repository.dart';

class UpdateComboUseCase {
  final ComboRepository repository;
  UpdateComboUseCase(this.repository);

  Future<void> call(String id, Map<String, dynamic> data) {
    return repository.updateCombo(id, data);
  }
}