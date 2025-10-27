import 'package:genesis_pt3/domain/Repositories/inventario/combos/combo_repository.dart';

class DeleteComboUseCase {
  final ComboRepository repository;
  DeleteComboUseCase(this.repository);

  Future<void> call(String id) {
    return repository.deleteCombo(id);
  }
}