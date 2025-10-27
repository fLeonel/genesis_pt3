class DashboardEntity {
  final double? ventasDiarias;
  final double? ventasMensuales;
  final List<TamalMasVendido>? tamalesMasVendidos;
  final List<BebidaPorHorario>? bebidasPorHorario;
  final ProporcionPicante? proporcionPicante;
  final double? utilidadTotal;
  final double? desperdicioMateriaPrima;

  DashboardEntity({
    this.ventasDiarias,
    this.ventasMensuales,
    this.tamalesMasVendidos,
    this.bebidasPorHorario,
    this.proporcionPicante,
    this.utilidadTotal,
    this.desperdicioMateriaPrima,
  });

  factory DashboardEntity.fromJson(Map<String, dynamic> json) => DashboardEntity(
    ventasDiarias: json['ventasDiarias']?.toDouble(),
    ventasMensuales: json['ventasMensuales']?.toDouble(),
    tamalesMasVendidos: json['tamalesMasVendidos'] != null 
        ? (json['tamalesMasVendidos'] as List).map((e) => TamalMasVendido.fromJson(e)).toList()
        : null,
    bebidasPorHorario: json['bebidasPorHorario'] != null 
        ? (json['bebidasPorHorario'] as List).map((e) => BebidaPorHorario.fromJson(e)).toList()
        : null,
    proporcionPicante: json['proporcionPicante'] != null 
        ? ProporcionPicante.fromJson(json['proporcionPicante']) 
        : null,
    utilidadTotal: json['utilidadTotal']?.toDouble(),
    desperdicioMateriaPrima: json['desperdicioMateriaPrima']?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'ventasDiarias': ventasDiarias,
    'ventasMensuales': ventasMensuales,
    'tamalesMasVendidos': tamalesMasVendidos?.map((e) => e.toJson()).toList(),
    'bebidasPorHorario': bebidasPorHorario?.map((e) => e.toJson()).toList(),
    'proporcionPicante': proporcionPicante?.toJson(),
    'utilidadTotal': utilidadTotal,
    'desperdicioMateriaPrima': desperdicioMateriaPrima,
  };
}

class TamalMasVendido {
  final String? nombre;
  final int? cantidad;

  TamalMasVendido({
    this.nombre,
    this.cantidad,
  });

  factory TamalMasVendido.fromJson(Map<String, dynamic> json) => TamalMasVendido(
    nombre: json['nombre'],
    cantidad: json['cantidad'],
  );

  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'cantidad': cantidad,
  };
}

class BebidaPorHorario {
  final String? hora;
  final double? ventas;

  BebidaPorHorario({
    this.hora,
    this.ventas,
  });

  factory BebidaPorHorario.fromJson(Map<String, dynamic> json) => BebidaPorHorario(
    hora: json['hora'],
    ventas: json['ventas']?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'hora': hora,
    'ventas': ventas,
  };
}

class ProporcionPicante {
  final int? picante;
  final int? noPicante;

  ProporcionPicante({
    this.picante,
    this.noPicante,
  });

  factory ProporcionPicante.fromJson(Map<String, dynamic> json) => ProporcionPicante(
    picante: json['picante'],
    noPicante: json['noPicante'],
  );

  Map<String, dynamic> toJson() => {
    'picante': picante,
    'noPicante': noPicante,
  };
}