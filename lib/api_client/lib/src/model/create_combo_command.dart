//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/create_combo_producto_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_combo_command.g.dart';

/// CreateComboCommand
///
/// Properties:
/// * [nombre] 
/// * [descripcion] 
/// * [precioTotal] 
/// * [productos] 
@BuiltValue()
abstract class CreateComboCommand implements Built<CreateComboCommand, CreateComboCommandBuilder> {
  @BuiltValueField(wireName: r'nombre')
  String? get nombre;

  @BuiltValueField(wireName: r'descripcion')
  String? get descripcion;

  @BuiltValueField(wireName: r'precioTotal')
  double? get precioTotal;

  @BuiltValueField(wireName: r'productos')
  BuiltList<CreateComboProductoDto>? get productos;

  CreateComboCommand._();

  factory CreateComboCommand([void updates(CreateComboCommandBuilder b)]) = _$CreateComboCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateComboCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateComboCommand> get serializer => _$CreateComboCommandSerializer();
}

class _$CreateComboCommandSerializer implements PrimitiveSerializer<CreateComboCommand> {
  @override
  final Iterable<Type> types = const [CreateComboCommand, _$CreateComboCommand];

  @override
  final String wireName = r'CreateComboCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateComboCommand object, {
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
    if (object.precioTotal != null) {
      yield r'precioTotal';
      yield serializers.serialize(
        object.precioTotal,
        specifiedType: const FullType(double),
      );
    }
    if (object.productos != null) {
      yield r'productos';
      yield serializers.serialize(
        object.productos,
        specifiedType: const FullType.nullable(BuiltList, [FullType(CreateComboProductoDto)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateComboCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateComboCommandBuilder result,
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
        case r'precioTotal':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.precioTotal = valueDes;
          break;
        case r'productos':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(CreateComboProductoDto)]),
          ) as BuiltList<CreateComboProductoDto>?;
          if (valueDes == null) continue;
          result.productos.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateComboCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateComboCommandBuilder();
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

