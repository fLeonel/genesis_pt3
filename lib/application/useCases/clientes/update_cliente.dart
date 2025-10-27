import 'package:genesis_pt3/domain/Repositories/clientes/cliente_repository.dart';

class UpdateClienteUseCase {
  final ClienteRepository repository;
  UpdateClienteUseCase(this.repository);

  Future<void> call(String id, Map<String, dynamic> data) {
    return repository.updateCliente(id, data);
  }
}