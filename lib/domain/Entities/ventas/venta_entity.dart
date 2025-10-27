class VentaEntity {
  final String? id;
  final String? clienteId;
  final String? metodoPago;
  final String? notas;
  final double? total;
  final String? estado; // pendiente, confirmada, cancelada
  final DateTime? fechaCreacion;
  final DateTime? fechaActualizacion;
  final List<VentaDetalleDto>? detalles;

  VentaEntity({
    this.id,
    this.clienteId,
    this.metodoPago,
    this.notas,
    this.total,
    this.estado,
    this.fechaCreacion,
    this.fechaActualizacion,
    this.detalles,
  });

  factory VentaEntity.fromJson(Map<String, dynamic> json) => VentaEntity(
    id: json['id'],
    clienteId: json['clienteId'],
    metodoPago: json['metodoPago'],
    notas: json['notas'],
    total: json['total']?.toDouble(),
    estado: json['estado'],
    fechaCreacion: json['fechaCreacion'] != null 
        ? DateTime.parse(json['fechaCreacion']) 
        : null,
    fechaActualizacion: json['fechaActualizacion'] != null 
        ? DateTime.parse(json['fechaActualizacion']) 
        : null,
    detalles: json['detalles'] != null 
        ? (json['detalles'] as List).map((e) => VentaDetalleDto.fromJson(e)).toList()
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'clienteId': clienteId,
    'metodoPago': metodoPago,
    'notas': notas,
    'total': total,
    'estado': estado,
    'fechaCreacion': fechaCreacion?.toIso8601String(),
    'fechaActualizacion': fechaActualizacion?.toIso8601String(),
    'detalles': detalles?.map((e) => e.toJson()).toList(),
  };
}

class VentaDetalleDto {
  final String? id;
  final String? productoId;
  final String? nombreProducto;
  final int? cantidad;
  final double? precioUnitario;
  final double? subtotal;

  VentaDetalleDto({
    this.id,
    this.productoId,
    this.nombreProducto,
    this.cantidad,
    this.precioUnitario,
    this.subtotal,
  });

  factory VentaDetalleDto.fromJson(Map<String, dynamic> json) => VentaDetalleDto(
    id: json['id'],
    productoId: json['productoId'],
    nombreProducto: json['nombreProducto'],
    cantidad: json['cantidad'],
    precioUnitario: json['precioUnitario']?.toDouble(),
    subtotal: json['subtotal']?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'productoId': productoId,
    'nombreProducto': nombreProducto,
    'cantidad': cantidad,
    'precioUnitario': precioUnitario,
    'subtotal': subtotal,
  };
}