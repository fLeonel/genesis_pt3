import 'package:genesis_pt3/domain/Entities/dashboard/dashboard_entity.dart';
import 'package:genesis_pt3/domain/Repositories/dashboard_repository.dart';
import 'package:genesis_pt3/infrastructure/http/api_client.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final ApiClient _apiClient;

  DashboardRepositoryImpl(this._apiClient);

  @override
  Future<DashboardEntity> getDashboardData() async {
    try {
      final response = await _apiClient.get('/dashboard');
      
      if (response.statusCode == 200 && response.data != null) {
        return DashboardEntity.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception('Error al obtener datos del dashboard');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}