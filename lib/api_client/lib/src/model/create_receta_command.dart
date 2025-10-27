//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/create_receta_detalle_dto.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_receta_command.g.dart';

/// CreateRecetaCommand
///
/// Properties:
/// * [nombre] 
/// * [productoId] 
/// * [descripcion] 
/// * [detalles] 
@BuiltValue()
abstract class CreateRecetaCommand implements Built<CreateRecetaCommand, CreateRecetaCommandBuilder> {
  @BuiltValueField(wireName: r'nombre')
  String get nombre;

  @BuiltValueField(wireName: r'productoId')
  String get productoId;

  @BuiltValueField(wireName: r'descripcion')
  String? get descripcion;

  @BuiltValueField(wireName: r'detalles')
  BuiltList<CreateRecetaDetalleDto>? get detalles;

  CreateRecetaCommand._();

  factory CreateRecetaCommand([void updates(CreateRecetaCommandBuilder b)]) = _$CreateRecetaCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateRecetaCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateRecetaCommand> get serializer => _$CreateRecetaCommandSerializer();
}

class _$CreateRecetaCommandSerializer implements PrimitiveSerializer<CreateRecetaCommand> {
  @override
  final Iterable<Type> types = const [CreateRecetaCommand, _$CreateRecetaCommand];

  @override
  final String wireName = r'CreateRecetaCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateRecetaCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'nombre';
    yield serializers.serialize(
      object.nombre,
      specifiedType: const FullType(String),
    );
    yield r'productoId';
    yield serializers.serialize(
      object.productoId,
      specifiedType: const FullType(String),
    );
    if (object.descripcion != null) {
      yield r'descripcion';
      yield serializers.serialize(
        object.descripcion,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.detalles != null) {
      yield r'detalles';
      yield serializers.serialize(
        object.detalles,
        specifiedType: const FullType.nullable(BuiltList, [FullType(CreateRecetaDetalleDto)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateRecetaCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateRecetaCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'nombre':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nombre = valueDes;
          break;
        case r'productoId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productoId = valueDes;
          break;
        case r'descripcion':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.descripcion = valueDes;
          break;
        case r'detalles':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(CreateRecetaDetalleDto)]),
          ) as BuiltList<CreateRecetaDetalleDto>?;
          if (valueDes == null) continue;
          result.detalles.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateRecetaCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateRecetaCommandBuilder();
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

