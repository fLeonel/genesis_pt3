//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'combo_producto_dto.g.dart';

/// ComboProductoDto
///
/// Properties:
/// * [productoId] 
/// * [cantidadPorCombo] 
@BuiltValue()
abstract class ComboProductoDto implements Built<ComboProductoDto, ComboProductoDtoBuilder> {
  @BuiltValueField(wireName: r'productoId')
  String? get productoId;

  @BuiltValueField(wireName: r'cantidadPorCombo')
  int? get cantidadPorCombo;

  ComboProductoDto._();

  factory ComboProductoDto([void updates(ComboProductoDtoBuilder b)]) = _$ComboProductoDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ComboProductoDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ComboProductoDto> get serializer => _$ComboProductoDtoSerializer();
}

class _$ComboProductoDtoSerializer implements PrimitiveSerializer<ComboProductoDto> {
  @override
  final Iterable<Type> types = const [ComboProductoDto, _$ComboProductoDto];

  @override
  final String wireName = r'ComboProductoDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ComboProductoDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.productoId != null) {
      yield r'productoId';
      yield serializers.serialize(
        object.productoId,
        specifiedType: const FullType(String),
      );
    }
    if (object.cantidadPorCombo != null) {
      yield r'cantidadPorCombo';
      yield serializers.serialize(
        object.cantidadPorCombo,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ComboProductoDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ComboProductoDtoBuilder result,
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
        case r'cantidadPorCombo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.cantidadPorCombo = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ComboProductoDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ComboProductoDtoBuilder();
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

