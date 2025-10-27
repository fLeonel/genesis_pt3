import 'package:genesis_pt3/domain/Entities/clientes/cliente_entity.dart';
import 'package:genesis_pt3/domain/Repositories/clientes/cliente_repository.dart';
import 'package:genesis_pt3/infrastructure/http/api_client.dart';

class ClienteRepositoryImpl implements ClienteRepository {
  final ApiClient _api;

  ClienteRepositoryImpl(this._api);

  @override
  Future<List<ClienteEntity>> getClientes() async {
    final response = await _api.get('/clientes');
    final List<dynamic> data = response.data;
    return data.map((e) => ClienteEntity.fromJson(e)).toList();
  }

  @override
  Future<ClienteEntity> getClienteById(String id) async {
    final response = await _api.get('/clientes/$id');
    return ClienteEntity.fromJson(response.data);
  }

  @override
  Future<void> createCliente(ClienteEntity cliente) async {
    final data = {
      'clienteCodigo': cliente.clienteCodigo,
      'nombre': cliente.nombre,
      'telefono': cliente.telefono,
      'correo': cliente.correo,
      'nit': cliente.nit,
      'direccion': cliente.direccion,
    };
    await _api.post('/clientes', data);
  }

  @override
  Future<void> updateCliente(String id, Map<String, dynamic> data) async {
    await _api.put('/clientes/$id', data);
  }

  @override
  Future<void> deleteCliente(String id) async {
    await _api.delete('/clientes/$id');
  }
}

