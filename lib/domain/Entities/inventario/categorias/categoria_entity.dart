class CategoriaEntity {
  final String? id;
  final String nombre;
  final String? descripcion;

  const CategoriaEntity({this.id, required this.nombre, this.descripcion});

  CategoriaEntity copyWith({String? id, String? nombre, String? descripcion}) {
    return CategoriaEntity(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
    );
  }
}
