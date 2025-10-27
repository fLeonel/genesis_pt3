//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_combo_producto_dto.g.dart';

/// CreateComboProductoDto
///
/// Properties:
/// * [productoId] 
/// * [cantidad] 
@BuiltValue()
abstract class CreateComboProductoDto implements Built<CreateComboProductoDto, CreateComboProductoDtoBuilder> {
  @BuiltValueField(wireName: r'productoId')
  String? get productoId;

  @BuiltValueField(wireName: r'cantidad')
  int? get cantidad;

  CreateComboProductoDto._();

  factory CreateComboProductoDto([void updates(CreateComboProductoDtoBuilder b)]) = _$CreateComboProductoDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateComboProductoDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateComboProductoDto> get serializer => _$CreateComboProductoDtoSerializer();
}

class _$CreateComboProductoDtoSerializer implements PrimitiveSerializer<CreateComboProductoDto> {
  @override
  final Iterable<Type> types = const [CreateComboProductoDto, _$CreateComboProductoDto];

  @override
  final String wireName = r'CreateComboProductoDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateComboProductoDto object, {
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
    CreateComboProductoDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateComboProductoDtoBuilder result,
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
  CreateComboProductoDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateComboProductoDtoBuilder();
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

