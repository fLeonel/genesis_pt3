class ComboEntity {
  final String? id;
  final String? nombre;
  final String? descripcion;
  final double? precioTotal;
  final List<ComboProductoDto>? productos;

  ComboEntity({
    this.id,
    this.nombre,
    this.descripcion,
    this.precioTotal,
    this.productos,
  });

  factory ComboEntity.fromJson(Map<String, dynamic> json) => ComboEntity(
    id: json['id'],
    nombre: json['nombre'],
    descripcion: json['descripcion'],
    precioTotal: json['precioTotal']?.toDouble(),
    productos: json['productos'] != null 
        ? (json['productos'] as List).map((e) => ComboProductoDto.fromJson(e)).toList()
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'descripcion': descripcion,
    'precioTotal': precioTotal,
    'productos': productos?.map((e) => e.toJson()).toList(),
  };
}

class ComboProductoDto {
  final String? productoId;
  final double? cantidad;

  ComboProductoDto({
    this.productoId,
    this.cantidad,
  });

  factory ComboProductoDto.fromJson(Map<String, dynamic> json) => ComboProductoDto(
    productoId: json['productoId'],
    cantidad: json['cantidad']?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'productoId': productoId,
    'cantidad': cantidad,
  };
}