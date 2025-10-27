class BodegaEntity {
  final String? id;
  final String? nombre;
  final String? descripcion;
  final String? bodegaPadreId;

  BodegaEntity({this.id, this.nombre, this.descripcion, this.bodegaPadreId});

  factory BodegaEntity.fromJson(Map<String, dynamic> json) => BodegaEntity(
    id: json['id'],
    nombre: json['nombre'],
    descripcion: json['descripcion'],
    bodegaPadreId: json['bodegaPadreId'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'descripcion': descripcion,
    'bodegaPadreId': bodegaPadreId,
  };
}
