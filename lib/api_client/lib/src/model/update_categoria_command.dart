//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_categoria_command.g.dart';

/// UpdateCategoriaCommand
///
/// Properties:
/// * [id] 
/// * [nombre] 
/// * [descripcion] 
@BuiltValue()
abstract class UpdateCategoriaCommand implements Built<UpdateCategoriaCommand, UpdateCategoriaCommandBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'nombre')
  String? get nombre;

  @BuiltValueField(wireName: r'descripcion')
  String? get descripcion;

  UpdateCategoriaCommand._();

  factory UpdateCategoriaCommand([void updates(UpdateCategoriaCommandBuilder b)]) = _$UpdateCategoriaCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateCategoriaCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateCategoriaCommand> get serializer => _$UpdateCategoriaCommandSerializer();
}

class _$UpdateCategoriaCommandSerializer implements PrimitiveSerializer<UpdateCategoriaCommand> {
  @override
  final Iterable<Type> types = const [UpdateCategoriaCommand, _$UpdateCategoriaCommand];

  @override
  final String wireName = r'UpdateCategoriaCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateCategoriaCommand object, {
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
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateCategoriaCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateCategoriaCommandBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateCategoriaCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateCategoriaCommandBuilder();
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

