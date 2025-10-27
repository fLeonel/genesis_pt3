//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_receta_detalle_dto.g.dart';

/// CreateRecetaDetalleDto
///
/// Properties:
/// * [productoIngredienteId] 
/// * [cantidadRequerida] 
/// * [unidadMedida] 
@BuiltValue()
abstract class CreateRecetaDetalleDto implements Built<CreateRecetaDetalleDto, CreateRecetaDetalleDtoBuilder> {
  @BuiltValueField(wireName: r'productoIngredienteId')
  String? get productoIngredienteId;

  @BuiltValueField(wireName: r'cantidadRequerida')
  double? get cantidadRequerida;

  @BuiltValueField(wireName: r'unidadMedida')
  String? get unidadMedida;

  CreateRecetaDetalleDto._();

  factory CreateRecetaDetalleDto([void updates(CreateRecetaDetalleDtoBuilder b)]) = _$CreateRecetaDetalleDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateRecetaDetalleDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateRecetaDetalleDto> get serializer => _$CreateRecetaDetalleDtoSerializer();
}

class _$CreateRecetaDetalleDtoSerializer implements PrimitiveSerializer<CreateRecetaDetalleDto> {
  @override
  final Iterable<Type> types = const [CreateRecetaDetalleDto, _$CreateRecetaDetalleDto];

  @override
  final String wireName = r'CreateRecetaDetalleDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateRecetaDetalleDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.productoIngredienteId != null) {
      yield r'productoIngredienteId';
      yield serializers.serialize(
        object.productoIngredienteId,
        specifiedType: const FullType(String),
      );
    }
    if (object.cantidadRequerida != null) {
      yield r'cantidadRequerida';
      yield serializers.serialize(
        object.cantidadRequerida,
        specifiedType: const FullType(double),
      );
    }
    if (object.unidadMedida != null) {
      yield r'unidadMedida';
      yield serializers.serialize(
        object.unidadMedida,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateRecetaDetalleDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateRecetaDetalleDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'productoIngredienteId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productoIngredienteId = valueDes;
          break;
        case r'cantidadRequerida':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.cantidadRequerida = valueDes;
          break;
        case r'unidadMedida':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.unidadMedida = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateRecetaDetalleDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateRecetaDetalleDtoBuilder();
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

