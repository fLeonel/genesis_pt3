//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/create_venta_detalle_dto.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_venta_command.g.dart';

/// CreateVentaCommand
///
/// Properties:
/// * [clienteId] 
/// * [metodoPago] 
/// * [notas] 
/// * [detalles] 
@BuiltValue()
abstract class CreateVentaCommand implements Built<CreateVentaCommand, CreateVentaCommandBuilder> {
  @BuiltValueField(wireName: r'clienteId')
  String? get clienteId;

  @BuiltValueField(wireName: r'metodoPago')
  String? get metodoPago;

  @BuiltValueField(wireName: r'notas')
  String? get notas;

  @BuiltValueField(wireName: r'detalles')
  BuiltList<CreateVentaDetalleDto>? get detalles;

  CreateVentaCommand._();

  factory CreateVentaCommand([void updates(CreateVentaCommandBuilder b)]) = _$CreateVentaCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateVentaCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateVentaCommand> get serializer => _$CreateVentaCommandSerializer();
}

class _$CreateVentaCommandSerializer implements PrimitiveSerializer<CreateVentaCommand> {
  @override
  final Iterable<Type> types = const [CreateVentaCommand, _$CreateVentaCommand];

  @override
  final String wireName = r'CreateVentaCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateVentaCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.clienteId != null) {
      yield r'clienteId';
      yield serializers.serialize(
        object.clienteId,
        specifiedType: const FullType(String),
      );
    }
    if (object.metodoPago != null) {
      yield r'metodoPago';
      yield serializers.serialize(
        object.metodoPago,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.notas != null) {
      yield r'notas';
      yield serializers.serialize(
        object.notas,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.detalles != null) {
      yield r'detalles';
      yield serializers.serialize(
        object.detalles,
        specifiedType: const FullType.nullable(BuiltList, [FullType(CreateVentaDetalleDto)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateVentaCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateVentaCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'clienteId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.clienteId = valueDes;
          break;
        case r'metodoPago':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.metodoPago = valueDes;
          break;
        case r'notas':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.notas = valueDes;
          break;
        case r'detalles':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(CreateVentaDetalleDto)]),
          ) as BuiltList<CreateVentaDetalleDto>?;
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
  CreateVentaCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateVentaCommandBuilder();
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

