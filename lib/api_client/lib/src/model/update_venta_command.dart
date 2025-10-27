//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/update_venta_detalle_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_venta_command.g.dart';

/// UpdateVentaCommand
///
/// Properties:
/// * [id] 
/// * [metodoPago] 
/// * [notas] 
/// * [detalles] 
@BuiltValue()
abstract class UpdateVentaCommand implements Built<UpdateVentaCommand, UpdateVentaCommandBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'metodoPago')
  String? get metodoPago;

  @BuiltValueField(wireName: r'notas')
  String? get notas;

  @BuiltValueField(wireName: r'detalles')
  BuiltList<UpdateVentaDetalleDto>? get detalles;

  UpdateVentaCommand._();

  factory UpdateVentaCommand([void updates(UpdateVentaCommandBuilder b)]) = _$UpdateVentaCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateVentaCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateVentaCommand> get serializer => _$UpdateVentaCommandSerializer();
}

class _$UpdateVentaCommandSerializer implements PrimitiveSerializer<UpdateVentaCommand> {
  @override
  final Iterable<Type> types = const [UpdateVentaCommand, _$UpdateVentaCommand];

  @override
  final String wireName = r'UpdateVentaCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateVentaCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
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
        specifiedType: const FullType.nullable(BuiltList, [FullType(UpdateVentaDetalleDto)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateVentaCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateVentaCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
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
            specifiedType: const FullType.nullable(BuiltList, [FullType(UpdateVentaDetalleDto)]),
          ) as BuiltList<UpdateVentaDetalleDto>?;
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
  UpdateVentaCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateVentaCommandBuilder();
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

