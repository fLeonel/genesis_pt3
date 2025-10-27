//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_producto_command.g.dart';

/// CreateProductoCommand
///
/// Properties:
/// * [nombre] 
/// * [categoriaId] 
/// * [bodegaId] 
/// * [precioPublico] 
/// * [costoUnitario] 
/// * [unidadMedida] 
/// * [sePuedeVender] 
/// * [sePuedeComprar] 
/// * [esFabricado] 
/// * [descripcion] 
/// * [atributos] 
/// * [cantidadDisponible] 
@BuiltValue()
abstract class CreateProductoCommand implements Built<CreateProductoCommand, CreateProductoCommandBuilder> {
  @BuiltValueField(wireName: r'nombre')
  String? get nombre;

  @BuiltValueField(wireName: r'categoriaId')
  String? get categoriaId;

  @BuiltValueField(wireName: r'bodegaId')
  String? get bodegaId;

  @BuiltValueField(wireName: r'precioPublico')
  double? get precioPublico;

  @BuiltValueField(wireName: r'costoUnitario')
  double? get costoUnitario;

  @BuiltValueField(wireName: r'unidadMedida')
  String? get unidadMedida;

  @BuiltValueField(wireName: r'sePuedeVender')
  bool? get sePuedeVender;

  @BuiltValueField(wireName: r'sePuedeComprar')
  bool? get sePuedeComprar;

  @BuiltValueField(wireName: r'esFabricado')
  bool? get esFabricado;

  @BuiltValueField(wireName: r'descripcion')
  String? get descripcion;

  @BuiltValueField(wireName: r'atributos')
  BuiltMap<String, String>? get atributos;

  @BuiltValueField(wireName: r'cantidadDisponible')
  double? get cantidadDisponible;

  CreateProductoCommand._();

  factory CreateProductoCommand([void updates(CreateProductoCommandBuilder b)]) = _$CreateProductoCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateProductoCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateProductoCommand> get serializer => _$CreateProductoCommandSerializer();
}

class _$CreateProductoCommandSerializer implements PrimitiveSerializer<CreateProductoCommand> {
  @override
  final Iterable<Type> types = const [CreateProductoCommand, _$CreateProductoCommand];

  @override
  final String wireName = r'CreateProductoCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateProductoCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.nombre != null) {
      yield r'nombre';
      yield serializers.serialize(
        object.nombre,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.categoriaId != null) {
      yield r'categoriaId';
      yield serializers.serialize(
        object.categoriaId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.bodegaId != null) {
      yield r'bodegaId';
      yield serializers.serialize(
        object.bodegaId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.precioPublico != null) {
      yield r'precioPublico';
      yield serializers.serialize(
        object.precioPublico,
        specifiedType: const FullType(double),
      );
    }
    if (object.costoUnitario != null) {
      yield r'costoUnitario';
      yield serializers.serialize(
        object.costoUnitario,
        specifiedType: const FullType(double),
      );
    }
    if (object.unidadMedida != null) {
      yield r'unidadMedida';
      yield serializers.serialize(
        object.unidadMedida,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.sePuedeVender != null) {
      yield r'sePuedeVender';
      yield serializers.serialize(
        object.sePuedeVender,
        specifiedType: const FullType(bool),
      );
    }
    if (object.sePuedeComprar != null) {
      yield r'sePuedeComprar';
      yield serializers.serialize(
        object.sePuedeComprar,
        specifiedType: const FullType(bool),
      );
    }
    if (object.esFabricado != null) {
      yield r'esFabricado';
      yield serializers.serialize(
        object.esFabricado,
        specifiedType: const FullType(bool),
      );
    }
    if (object.descripcion != null) {
      yield r'descripcion';
      yield serializers.serialize(
        object.descripcion,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.atributos != null) {
      yield r'atributos';
      yield serializers.serialize(
        object.atributos,
        specifiedType: const FullType.nullable(BuiltMap, [FullType(String), FullType(String)]),
      );
    }
    if (object.cantidadDisponible != null) {
      yield r'cantidadDisponible';
      yield serializers.serialize(
        object.cantidadDisponible,
        specifiedType: const FullType(double),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateProductoCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateProductoCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'nombre':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.nombre = valueDes;
          break;
        case r'categoriaId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.categoriaId = valueDes;
          break;
        case r'bodegaId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.bodegaId = valueDes;
          break;
        case r'precioPublico':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.precioPublico = valueDes;
          break;
        case r'costoUnitario':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.costoUnitario = valueDes;
          break;
        case r'unidadMedida':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.unidadMedida = valueDes;
          break;
        case r'sePuedeVender':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.sePuedeVender = valueDes;
          break;
        case r'sePuedeComprar':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.sePuedeComprar = valueDes;
          break;
        case r'esFabricado':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.esFabricado = valueDes;
          break;
        case r'descripcion':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.descripcion = valueDes;
          break;
        case r'atributos':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltMap, [FullType(String), FullType(String)]),
          ) as BuiltMap<String, String>?;
          if (valueDes == null) continue;
          result.atributos.replace(valueDes);
          break;
        case r'cantidadDisponible':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.cantidadDisponible = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateProductoCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateProductoCommandBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

