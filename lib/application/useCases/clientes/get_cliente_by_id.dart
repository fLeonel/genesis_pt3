import 'package:genesis_pt3/domain/Entities/clientes/cliente_entity.dart';
import 'package:genesis_pt3/domain/Repositories/clientes/cliente_repository.dart';

class GetClienteByIdUseCase {
  final ClienteRepository repository;
  GetClienteByIdUseCase(this.repository);

  Future<ClienteEntity> call(String id) {
    return repository.getClienteById(id);
  }
}