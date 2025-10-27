import 'package:genesis_pt3/domain/Entities/dashboard/dashboard_entity.dart';
import 'package:genesis_pt3/domain/Repositories/dashboard_repository.dart';

class MockDashboardRepository implements DashboardRepository {
  @override
  Future<DashboardEntity> getDashboardData() async {
    // Simular una llamada de red
    await Future.delayed(const Duration(seconds: 1));
    
    return DashboardEntity(
      ventasDiarias: 0.0,
      ventasMensuales: 163.0,
      tamalesMasVendidos: [
        TamalMasVendido(nombre: "Tamal Dulce", cantidad: 11),
        TamalMasVendido(nombre: "Chocolate Mediano", cantidad: 11),
        TamalMasVendido(nombre: "Tamal Nacional", cantidad: 2),
      ],
      bebidasPorHorario: [
        BebidaPorHorario(hora: "11:00", ventas: 36.0),
        BebidaPorHorario(hora: "14:00", ventas: 61.0),
        BebidaPorHorario(hora: "19:00", ventas: 40.0),
        BebidaPorHorario(hora: "22:00", ventas: 26.0),
      ],
      proporcionPicante: ProporcionPicante(picante: 0, noPicante: 7),
      utilidadTotal: 76.0,
      desperdicioMateriaPrima: 0.0,
    );
  }
}