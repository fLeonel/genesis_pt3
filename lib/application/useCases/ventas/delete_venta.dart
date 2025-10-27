import 'package:genesis_pt3/domain/Repositories/ventas/venta_repository.dart';

class DeleteVentaUseCase {
  final VentaRepository repository;
  DeleteVentaUseCase(this.repository);

  Future<void> call(String id) {
    return repository.deleteVenta(id);
  }
}