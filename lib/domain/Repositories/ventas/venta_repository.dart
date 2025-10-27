import 'package:genesis_pt3/domain/Entities/ventas/venta_entity.dart';

abstract class VentaRepository {
  Future<List<VentaEntity>> getVentas();
  Future<VentaEntity> getVentaById(String id);
  Future<void> createVenta(VentaEntity venta);
  Future<void> updateVenta(String id, Map<String, dynamic> data);
  Future<void> deleteVenta(String id);
  Future<void> confirmarVenta(String id);
}