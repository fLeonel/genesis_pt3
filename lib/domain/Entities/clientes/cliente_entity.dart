class ClienteEntity {
  final String? id;
  final String? clienteCodigo;
  final String? nombre;
  final String? telefono;
  final String? correo;
  final String? nit;
  final String? direccion;
  final DateTime? fechaCreacion;
  final DateTime? fechaActualizacion;

  ClienteEntity({
    this.id,
    this.clienteCodigo,
    this.nombre,
    this.telefono,
    this.correo,
    this.nit,
    this.direccion,
    this.fechaCreacion,
    this.fechaActualizacion,
  });

  factory ClienteEntity.fromJson(Map<String, dynamic> json) => ClienteEntity(
    id: json['id'],
    clienteCodigo: json['clienteCodigo'],
    nombre: json['nombre'],
    telefono: json['telefono'],
    correo: json['correo'],
    nit: json['nit'],
    direccion: json['direccion'],
    fechaCreacion: json['fechaCreacion'] != null 
        ? DateTime.parse(json['fechaCreacion']) 
        : null,
    fechaActualizacion: json['fechaActualizacion'] != null 
        ? DateTime.parse(json['fechaActualizacion']) 
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'clienteCodigo': clienteCodigo,
    'nombre': nombre,
    'telefono': telefono,
    'correo': correo,
    'nit': nit,
    'direccion': direccion,
    'fechaCreacion': fechaCreacion?.toIso8601String(),
    'fechaActualizacion': fechaActualizacion?.toIso8601String(),
  };
}