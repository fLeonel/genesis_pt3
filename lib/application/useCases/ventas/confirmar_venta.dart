import 'package:genesis_pt3/domain/Repositories/ventas/venta_repository.dart';

class ConfirmarVentaUseCase {
  final VentaRepository repository;
  ConfirmarVentaUseCase(this.repository);

  Future<void> call(String id) {
    return repository.confirmarVenta(id);
  }
}