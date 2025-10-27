//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_venta_detalle_dto.g.dart';

/// CreateVentaDetalleDto
///
/// Properties:
/// * [productoId] 
/// * [cantidad] 
@BuiltValue()
abstract class CreateVentaDetalleDto implements Built<CreateVentaDetalleDto, CreateVentaDetalleDtoBuilder> {
  @BuiltValueField(wireName: r'productoId')
  String? get productoId;

  @BuiltValueField(wireName: r'cantidad')
  int? get cantidad;

  CreateVentaDetalleDto._();

  factory CreateVentaDetalleDto([void updates(CreateVentaDetalleDtoBuilder b)]) = _$CreateVentaDetalleDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateVentaDetalleDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateVentaDetalleDto> get serializer => _$CreateVentaDetalleDtoSerializer();
}

class _$CreateVentaDetalleDtoSerializer implements PrimitiveSerializer<CreateVentaDetalleDto> {
  @override
  final Iterable<Type> types = const [CreateVentaDetalleDto, _$CreateVentaDetalleDto];

  @override
  final String wireName = r'CreateVentaDetalleDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateVentaDetalleDto object, {
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
    CreateVentaDetalleDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateVentaDetalleDtoBuilder result,
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
  CreateVentaDetalleDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateVentaDetalleDtoBuilder();
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

