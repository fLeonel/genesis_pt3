import 'package:genesis_pt3/domain/Entities/clientes/cliente_entity.dart';
import 'package:genesis_pt3/domain/Repositories/clientes/cliente_repository.dart';

class CreateClienteUseCase {
  final ClienteRepository repository;
  CreateClienteUseCase(this.repository);

  Future<void> call(ClienteEntity cliente) {
    return repository.createCliente(cliente);
  }
}