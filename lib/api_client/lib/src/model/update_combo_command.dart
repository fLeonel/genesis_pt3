//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/combo_producto_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_combo_command.g.dart';

/// UpdateComboCommand
///
/// Properties:
/// * [id] 
/// * [nombre] 
/// * [descripcion] 
/// * [precioTotal] 
/// * [productos] 
@BuiltValue()
abstract class UpdateComboCommand implements Built<UpdateComboCommand, UpdateComboCommandBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'nombre')
  String? get nombre;

  @BuiltValueField(wireName: r'descripcion')
  String? get descripcion;

  @BuiltValueField(wireName: r'precioTotal')
  double? get precioTotal;

  @BuiltValueField(wireName: r'productos')
  BuiltList<ComboProductoDto>? get productos;

  UpdateComboCommand._();

  factory UpdateComboCommand([void updates(UpdateComboCommandBuilder b)]) = _$UpdateComboCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateComboCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateComboCommand> get serializer => _$UpdateComboCommandSerializer();
}

class _$UpdateComboCommandSerializer implements PrimitiveSerializer<UpdateComboCommand> {
  @override
  final Iterable<Type> types = const [UpdateComboCommand, _$UpdateComboCommand];

  @override
  final String wireName = r'UpdateComboCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateComboCommand object, {
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
        specifiedType: const FullType.nullable(BuiltList, [FullType(ComboProductoDto)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateComboCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateComboCommandBuilder result,
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
            specifiedType: const FullType.nullable(BuiltList, [FullType(ComboProductoDto)]),
          ) as BuiltList<ComboProductoDto>?;
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
  UpdateComboCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateComboCommandBuilder();
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

