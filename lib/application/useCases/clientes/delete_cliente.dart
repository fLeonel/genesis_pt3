import 'package:genesis_pt3/domain/Repositories/clientes/cliente_repository.dart';

class DeleteClienteUseCase {
  final ClienteRepository repository;
  DeleteClienteUseCase(this.repository);

  Future<void> call(String id) {
    return repository.deleteCliente(id);
  }
}