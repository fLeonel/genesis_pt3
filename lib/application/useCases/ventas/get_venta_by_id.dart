import 'package:genesis_pt3/domain/Entities/ventas/venta_entity.dart';
import 'package:genesis_pt3/domain/Repositories/ventas/venta_repository.dart';

class GetVentaByIdUseCase {
  final VentaRepository repository;
  GetVentaByIdUseCase(this.repository);

  Future<VentaEntity> call(String id) {
    return repository.getVentaById(id);
  }
}