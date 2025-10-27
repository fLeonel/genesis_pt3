import 'package:genesis_pt3/domain/Entities/clientes/cliente_entity.dart';

abstract class ClienteRepository {
  Future<List<ClienteEntity>> getClientes();
  Future<ClienteEntity> getClienteById(String id);
  Future<void> createCliente(ClienteEntity cliente);
  Future<void> updateCliente(String id, Map<String, dynamic> data);
  Future<void> deleteCliente(String id);
}