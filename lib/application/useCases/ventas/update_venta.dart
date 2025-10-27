import 'package:genesis_pt3/domain/Repositories/ventas/venta_repository.dart';

class UpdateVentaUseCase {
  final VentaRepository repository;
  UpdateVentaUseCase(this.repository);

  Future<void> call(String id, Map<String, dynamic> data) {
    return repository.updateVenta(id, data);
  }
}