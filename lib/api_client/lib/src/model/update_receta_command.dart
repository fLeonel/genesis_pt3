//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/update_receta_detalle_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_receta_command.g.dart';

/// UpdateRecetaCommand
///
/// Properties:
/// * [id] 
/// * [nombre] 
/// * [descripcion] 
/// * [detalles] 
@BuiltValue()
abstract class UpdateRecetaCommand implements Built<UpdateRecetaCommand, UpdateRecetaCommandBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'nombre')
  String? get nombre;

  @BuiltValueField(wireName: r'descripcion')
  String? get descripcion;

  @BuiltValueField(wireName: r'detalles')
  BuiltList<UpdateRecetaDetalleDto>? get detalles;

  UpdateRecetaCommand._();

  factory UpdateRecetaCommand([void updates(UpdateRecetaCommandBuilder b)]) = _$UpdateRecetaCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateRecetaCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateRecetaCommand> get serializer => _$UpdateRecetaCommandSerializer();
}

class _$UpdateRecetaCommandSerializer implements PrimitiveSerializer<UpdateRecetaCommand> {
  @override
  final Iterable<Type> types = const [UpdateRecetaCommand, _$UpdateRecetaCommand];

  @override
  final String wireName = r'UpdateRecetaCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateRecetaCommand object, {
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
    if (object.detalles != null) {
      yield r'detalles';
      yield serializers.serialize(
        object.detalles,
        specifiedType: const FullType.nullable(BuiltList, [FullType(UpdateRecetaDetalleDto)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateRecetaCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateRecetaCommandBuilder result,
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
        case r'detalles':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(UpdateRecetaDetalleDto)]),
          ) as BuiltList<UpdateRecetaDetalleDto>?;
          if (valueDes == null) continue;
          result.detalles.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateRecetaCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateRecetaCommandBuilder();
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

