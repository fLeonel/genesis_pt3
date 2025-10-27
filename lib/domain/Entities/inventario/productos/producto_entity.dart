class ProductoEntity {
  final String? id;
  final String? nombre;
  final String? categoriaId;
  final String? bodegaId;
  final double? precioPublico;
  final double? costoUnitario;
  final String? unidadMedida;
  final bool? sePuedeVender;
  final bool? sePuedeComprar;
  final bool? esFabricado;
  final String? descripcion;
  final Map<String, String>? atributos;
  final double? cantidadDisponible;

  ProductoEntity({
    this.id,
    this.nombre,
    this.categoriaId,
    this.bodegaId,
    this.precioPublico,
    this.costoUnitario,
    this.unidadMedida,
    this.sePuedeVender,
    this.sePuedeComprar,
    this.esFabricado,
    this.descripcion,
    this.atributos,
    this.cantidadDisponible,
  });

  factory ProductoEntity.fromJson(Map<String, dynamic> json) => ProductoEntity(
    id: json['id'],
    nombre: json['nombre'],
    categoriaId: json['categoriaId'],
    bodegaId: json['bodegaId'],
    precioPublico: json['precioPublico']?.toDouble(),
    costoUnitario: json['costoUnitario']?.toDouble(),
    unidadMedida: json['unidadMedida'],
    sePuedeVender: json['sePuedeVender'],
    sePuedeComprar: json['sePuedeComprar'],
    esFabricado: json['esFabricado'],
    descripcion: json['descripcion'],
    atributos: json['atributos'] != null 
        ? Map<String, String>.from(json['atributos']) 
        : null,
    cantidadDisponible: json['cantidadDisponible']?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'categoriaId': categoriaId,
    'bodegaId': bodegaId,
    'precioPublico': precioPublico,
    'costoUnitario': costoUnitario,
    'unidadMedida': unidadMedida,
    'sePuedeVender': sePuedeVender,
    'sePuedeComprar': sePuedeComprar,
    'esFabricado': esFabricado,
    'descripcion': descripcion,
    'atributos': atributos,
    'cantidadDisponible': cantidadDisponible,
  };
}