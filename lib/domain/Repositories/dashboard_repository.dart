import 'package:genesis_pt3/domain/Entities/dashboard/dashboard_entity.dart';

abstract class DashboardRepository {
  Future<DashboardEntity> getDashboardData();
}