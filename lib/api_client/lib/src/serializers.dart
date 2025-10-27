//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:openapi/src/date_serializer.dart';
import 'package:openapi/src/model/date.dart';

import 'package:openapi/src/model/combo_producto_dto.dart';
import 'package:openapi/src/model/create_bodega_command.dart';
import 'package:openapi/src/model/create_categoria_command.dart';
import 'package:openapi/src/model/create_cliente_command.dart';
import 'package:openapi/src/model/create_combo_command.dart';
import 'package:openapi/src/model/create_combo_producto_dto.dart';
import 'package:openapi/src/model/create_producto_command.dart';
import 'package:openapi/src/model/create_receta_command.dart';
import 'package:openapi/src/model/create_receta_detalle_dto.dart';
import 'package:openapi/src/model/create_venta_command.dart';
import 'package:openapi/src/model/create_venta_detalle_dto.dart';
import 'package:openapi/src/model/update_bodega_command.dart';
import 'package:openapi/src/model/update_categoria_command.dart';
import 'package:openapi/src/model/update_cliente_command.dart';
import 'package:openapi/src/model/update_combo_command.dart';
import 'package:openapi/src/model/update_producto_command.dart';
import 'package:openapi/src/model/update_receta_command.dart';
import 'package:openapi/src/model/update_receta_detalle_dto.dart';
import 'package:openapi/src/model/update_venta_command.dart';
import 'package:openapi/src/model/update_venta_detalle_dto.dart';

part 'serializers.g.dart';

@SerializersFor([
  ComboProductoDto,
  CreateBodegaCommand,
  CreateCategoriaCommand,
  CreateClienteCommand,
  CreateComboCommand,
  CreateComboProductoDto,
  CreateProductoCommand,
  CreateRecetaCommand,
  CreateRecetaDetalleDto,
  CreateVentaCommand,
  CreateVentaDetalleDto,
  UpdateBodegaCommand,
  UpdateCategoriaCommand,
  UpdateClienteCommand,
  UpdateComboCommand,
  UpdateProductoCommand,
  UpdateRecetaCommand,
  UpdateRecetaDetalleDto,
  UpdateVentaCommand,
  UpdateVentaDetalleDto,
])
Serializers serializers = (_$serializers.toBuilder()
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer())
    ).build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
