import 'package:genesis_pt3/domain/Entities/clientes/cliente_entity.dart';
import 'package:genesis_pt3/domain/Repositories/clientes/cliente_repository.dart';

class GetClientesUseCase {
  final ClienteRepository repository;
  GetClientesUseCase(this.repository);

  Future<List<ClienteEntity>> call() {
    return repository.getClientes();
  }
}