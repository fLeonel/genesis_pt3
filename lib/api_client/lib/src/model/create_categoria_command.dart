//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_categoria_command.g.dart';

/// CreateCategoriaCommand
///
/// Properties:
/// * [nombre] 
/// * [descripcion] 
@BuiltValue()
abstract class CreateCategoriaCommand implements Built<CreateCategoriaCommand, CreateCategoriaCommandBuilder> {
  @BuiltValueField(wireName: r'nombre')
  String? get nombre;

  @BuiltValueField(wireName: r'descripcion')
  String? get descripcion;

  CreateCategoriaCommand._();

  factory CreateCategoriaCommand([void updates(CreateCategoriaCommandBuilder b)]) = _$CreateCategoriaCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateCategoriaCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateCategoriaCommand> get serializer => _$CreateCategoriaCommandSerializer();
}

class _$CreateCategoriaCommandSerializer implements PrimitiveSerializer<CreateCategoriaCommand> {
  @override
  final Iterable<Type> types = const [CreateCategoriaCommand, _$CreateCategoriaCommand];

  @override
  final String wireName = r'CreateCategoriaCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateCategoriaCommand object, {
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
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateCategoriaCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateCategoriaCommandBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateCategoriaCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateCategoriaCommandBuilder();
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

