import 'package:genesis_pt3/domain/Entities/ventas/venta_entity.dart';
import 'package:genesis_pt3/domain/Repositories/ventas/venta_repository.dart';

class GetVentasUseCase {
  final VentaRepository repository;
  GetVentasUseCase(this.repository);

  Future<List<VentaEntity>> call() {
    return repository.getVentas();
  }
}