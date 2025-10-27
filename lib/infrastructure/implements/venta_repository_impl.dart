import 'package:genesis_pt3/domain/Entities/ventas/venta_entity.dart';
import 'package:genesis_pt3/domain/Repositories/ventas/venta_repository.dart';
import 'package:genesis_pt3/infrastructure/http/api_client.dart';

class VentaRepositoryImpl implements VentaRepository {
  final ApiClient _api;

  VentaRepositoryImpl(this._api);

  @override
  Future<List<VentaEntity>> getVentas() async {
    final response = await _api.get('/ventas');
    final List<dynamic> data = response.data;
    return data.map((e) => VentaEntity.fromJson(e)).toList();
  }

  @override
  Future<VentaEntity> getVentaById(String id) async {
    final response = await _api.get('/ventas/$id');
    return VentaEntity.fromJson(response.data);
  }

  @override
  Future<void> createVenta(VentaEntity venta) async {
    final data = {
      'clienteId': venta.clienteId,
      'metodoPago': venta.metodoPago,
      'notas': venta.notas,
      'detalles': venta.detalles
          ?.map(
            (detalle) => {
              'productoId': detalle.productoId,
              'cantidad': detalle.cantidad,
            },
          )
          .toList(),
    };
    await _api.post('/ventas', data);
  }

  @override
  Future<void> updateVenta(String id, Map<String, dynamic> data) async {
    await _api.put('/ventas/$id', data);
  }

  @override
  Future<void> deleteVenta(String id) async {
    await _api.delete('/ventas/$id');
  }

  @override
  Future<void> confirmarVenta(String id) async {
    await _api.put('/$id/confirmar', {});
  }
}

