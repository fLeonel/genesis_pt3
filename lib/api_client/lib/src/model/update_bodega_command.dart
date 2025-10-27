//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_bodega_command.g.dart';

/// UpdateBodegaCommand
///
/// Properties:
/// * [id] 
/// * [nombre] 
/// * [descripcion] 
/// * [bodegaPadreId] 
@BuiltValue()
abstract class UpdateBodegaCommand implements Built<UpdateBodegaCommand, UpdateBodegaCommandBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'nombre')
  String? get nombre;

  @BuiltValueField(wireName: r'descripcion')
  String? get descripcion;

  @BuiltValueField(wireName: r'bodegaPadreId')
  String? get bodegaPadreId;

  UpdateBodegaCommand._();

  factory UpdateBodegaCommand([void updates(UpdateBodegaCommandBuilder b)]) = _$UpdateBodegaCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateBodegaCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateBodegaCommand> get serializer => _$UpdateBodegaCommandSerializer();
}

class _$UpdateBodegaCommandSerializer implements PrimitiveSerializer<UpdateBodegaCommand> {
  @override
  final Iterable<Type> types = const [UpdateBodegaCommand, _$UpdateBodegaCommand];

  @override
  final String wireName = r'UpdateBodegaCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateBodegaCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
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
    UpdateBodegaCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateBodegaCommandBuilder result,
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
  UpdateBodegaCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateBodegaCommandBuilder();
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

