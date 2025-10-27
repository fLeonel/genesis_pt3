import 'package:genesis_pt3/domain/Entities/ventas/venta_entity.dart';
import 'package:genesis_pt3/domain/Repositories/ventas/venta_repository.dart';

class CreateVentaUseCase {
  final VentaRepository repository;
  CreateVentaUseCase(this.repository);

  Future<void> call(VentaEntity venta) {
    return repository.createVenta(venta);
  }
}