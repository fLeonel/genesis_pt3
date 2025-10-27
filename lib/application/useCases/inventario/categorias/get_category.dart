import 'package:genesis_pt3/domain/Entities/inventario/categorias/categoria_entity.dart';
import 'package:genesis_pt3/infrastructure/http/inventario/categorias/categoria_repository_impl.dart';

class GetCategoriaUseCase {
  final CategoriaRepository repository;
  GetCategoriaUseCase(this.repository);

  Future<List<CategoriaEntity>> call() async {
    return await repository.getCategorias();
  }
}
