//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_bodega_command.g.dart';

/// CreateBodegaCommand
///
/// Properties:
/// * [nombre] 
/// * [descripcion] 
/// * [bodegaPadreId] 
@BuiltValue()
abstract class CreateBodegaCommand implements Built<CreateBodegaCommand, CreateBodegaCommandBuilder> {
  @BuiltValueField(wireName: r'nombre')
  String? get nombre;

  @BuiltValueField(wireName: r'descripcion')
  String? get descripcion;

  @BuiltValueField(wireName: r'bodegaPadreId')
  String? get bodegaPadreId;

  CreateBodegaCommand._();

  factory CreateBodegaCommand([void updates(CreateBodegaCommandBuilder b)]) = _$CreateBodegaCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateBodegaCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateBodegaCommand> get serializer => _$CreateBodegaCommandSerializer();
}

class _$CreateBodegaCommandSerializer implements PrimitiveSerializer<CreateBodegaCommand> {
  @override
  final Iterable<Type> types = const [CreateBodegaCommand, _$CreateBodegaCommand];

  @override
  final String wireName = r'CreateBodegaCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateBodegaCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.nombre != null) {
      yield r'nombre';
      yield serializers.serialize(
        object.nombre,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.descripcion != null) {
      yield r'descripcion';
      yield serializers.serialize(
        object.descripcion,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.bodegaPadreId != null) {
      yield r'bodegaPadreId';
      yield serializers.serialize(
        object.bodegaPadreId,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateBodegaCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateBodegaCommandBuilder result,
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
        case r'descripcion':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.descripcion = valueDes;
          break;
        case r'bodegaPadreId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.bodegaPadreId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateBodegaCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateBodegaCommandBuilder();
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

