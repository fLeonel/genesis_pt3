class RecetaEntity {
  final String? id;
  final String? nombre;
  final String? productoId;
  final String? descripcion;
  final List<RecetaDetalleDto>? detalles;

  RecetaEntity({
    this.id,
    this.nombre,
    this.productoId,
    this.descripcion,
    this.detalles,
  });

  factory RecetaEntity.fromJson(Map<String, dynamic> json) => RecetaEntity(
    id: json['id'],
    nombre: json['nombre'],
    productoId: json['productoId'],
    descripcion: json['descripcion'],
    detalles: json['detalles'] != null 
        ? (json['detalles'] as List).map((e) => RecetaDetalleDto.fromJson(e)).toList()
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'productoId': productoId,
    'descripcion': descripcion,
    'detalles': detalles?.map((e) => e.toJson()).toList(),
  };
}

class RecetaDetalleDto {
  final String? productoId;
  final double? cantidadRequerida;

  RecetaDetalleDto({
    this.productoId,
    this.cantidadRequerida,
  });

  factory RecetaDetalleDto.fromJson(Map<String, dynamic> json) => RecetaDetalleDto(
    productoId: json['productoId'],
    cantidadRequerida: json['cantidadRequerida']?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'productoId': productoId,
    'cantidadRequerida': cantidadRequerida,
  };
}