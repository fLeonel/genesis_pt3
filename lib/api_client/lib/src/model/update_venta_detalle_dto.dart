//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_venta_detalle_dto.g.dart';

/// UpdateVentaDetalleDto
///
/// Properties:
/// * [productoId] 
/// * [cantidad] 
@BuiltValue()
abstract class UpdateVentaDetalleDto implements Built<UpdateVentaDetalleDto, UpdateVentaDetalleDtoBuilder> {
  @BuiltValueField(wireName: r'productoId')
  String? get productoId;

  @BuiltValueField(wireName: r'cantidad')
  int? get cantidad;

  UpdateVentaDetalleDto._();

  factory UpdateVentaDetalleDto([void updates(UpdateVentaDetalleDtoBuilder b)]) = _$UpdateVentaDetalleDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateVentaDetalleDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateVentaDetalleDto> get serializer => _$UpdateVentaDetalleDtoSerializer();
}

class _$UpdateVentaDetalleDtoSerializer implements PrimitiveSerializer<UpdateVentaDetalleDto> {
  @override
  final Iterable<Type> types = const [UpdateVentaDetalleDto, _$UpdateVentaDetalleDto];

  @override
  final String wireName = r'UpdateVentaDetalleDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateVentaDetalleDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.productoId != null) {
      yield r'productoId';
      yield serializers.serialize(
        object.productoId,
        specifiedType: const FullType(String),
      );
    }
    if (object.cantidad != null) {
      yield r'cantidad';
      yield serializers.serialize(
        object.cantidad,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateVentaDetalleDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateVentaDetalleDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'productoId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productoId = valueDes;
          break;
        case r'cantidad':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.cantidad = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateVentaDetalleDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateVentaDetalleDtoBuilder();
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

