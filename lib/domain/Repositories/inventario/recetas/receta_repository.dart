import 'package:genesis_pt3/domain/Entities/inventario/recetas/receta_entity.dart';

abstract class RecetaRepository {
  Future<List<RecetaEntity>> getRecetas();
  Future<RecetaEntity> getRecetaById(String id);
  Future<void> createReceta(RecetaEntity receta);
  Future<void> updateReceta(String id, Map<String, dynamic> data);
  Future<void> deleteReceta(String id);
}