//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_cliente_command.g.dart';

/// CreateClienteCommand
///
/// Properties:
/// * [clienteCodigo] 
/// * [nombre] 
/// * [telefono] 
/// * [correo] 
/// * [nit] 
/// * [direccion] 
@BuiltValue()
abstract class CreateClienteCommand implements Built<CreateClienteCommand, CreateClienteCommandBuilder> {
  @BuiltValueField(wireName: r'clienteCodigo')
  String? get clienteCodigo;

  @BuiltValueField(wireName: r'nombre')
  String? get nombre;

  @BuiltValueField(wireName: r'telefono')
  String? get telefono;

  @BuiltValueField(wireName: r'correo')
  String? get correo;

  @BuiltValueField(wireName: r'nit')
  String? get nit;

  @BuiltValueField(wireName: r'direccion')
  String? get direccion;

  CreateClienteCommand._();

  factory CreateClienteCommand([void updates(CreateClienteCommandBuilder b)]) = _$CreateClienteCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateClienteCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateClienteCommand> get serializer => _$CreateClienteCommandSerializer();
}

class _$CreateClienteCommandSerializer implements PrimitiveSerializer<CreateClienteCommand> {
  @override
  final Iterable<Type> types = const [CreateClienteCommand, _$CreateClienteCommand];

  @override
  final String wireName = r'CreateClienteCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateClienteCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.clienteCodigo != null) {
      yield r'clienteCodigo';
      yield serializers.serialize(
        object.clienteCodigo,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.nombre != null) {
      yield r'nombre';
      yield serializers.serialize(
        object.nombre,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.telefono != null) {
      yield r'telefono';
      yield serializers.serialize(
        object.telefono,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.correo != null) {
      yield r'correo';
      yield serializers.serialize(
        object.correo,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.nit != null) {
      yield r'nit';
      yield serializers.serialize(
        object.nit,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.direccion != null) {
      yield r'direccion';
      yield serializers.serialize(
        object.direccion,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateClienteCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateClienteCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'clienteCodigo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.clienteCodigo = valueDes;
          break;
        case r'nombre':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.nombre = valueDes;
          break;
        case r'telefono':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.telefono = valueDes;
          break;
        case r'correo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.correo = valueDes;
          break;
        case r'nit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.nit = valueDes;
          break;
        case r'direccion':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.direccion = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateClienteCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateClienteCommandBuilder();
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

