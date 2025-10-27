import 'package:genesis_pt3/domain/Entities/dashboard/dashboard_entity.dart';
import 'package:genesis_pt3/domain/Repositories/dashboard_repository.dart';

class GetDashboardDataUseCase {
  final DashboardRepository _repository;

  GetDashboardDataUseCase(this._repository);

  Future<DashboardEntity> call() async {
    return await _repository.getDashboardData();
  }
}