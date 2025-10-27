import 'package:flutter/material.dart';
import 'package:genesis_pt3/application/useCases/ventas/create_venta.dart';
import 'package:genesis_pt3/application/useCases/ventas/delete_venta.dart';
import 'package:genesis_pt3/application/useCases/ventas/get_ventas.dart';
import 'package:genesis_pt3/application/useCases/ventas/get_venta_by_id.dart';
import 'package:genesis_pt3/application/useCases/ventas/update_venta.dart';
import 'package:genesis_pt3/application/useCases/ventas/confirmar_venta.dart';
import 'package:genesis_pt3/application/useCases/clientes/get_clientes.dart';
import 'package:genesis_pt3/application/useCases/inventario/productos/get_productos.dart';
import 'package:genesis_pt3/domain/Entities/ventas/venta_entity.dart';
import 'package:genesis_pt3/domain/Entities/clientes/cliente_entity.dart';
import 'package:genesis_pt3/domain/Entities/inventario/productos/producto_entity.dart';
import 'package:genesis_pt3/infrastructure/http/api_client.dart';
import 'package:genesis_pt3/infrastructure/implements/venta_repository_impl.dart';
import 'package:genesis_pt3/infrastructure/implements/cliente_repository_impl.dart';
import 'package:genesis_pt3/infrastructure/implements/producto_repository_impl.dart';

class VentasScreen extends StatefulWidget {
  const VentasScreen({super.key});

  @override
  State<VentasScreen> createState() => _VentasScreenState();
}

class _VentasScreenState extends State<VentasScreen> {
  // Repositorios y casos de uso
  late final _repo = VentaRepositoryImpl(ApiClient());
  late final _clienteRepo = ClienteRepositoryImpl(ApiClient());
  late final _productoRepo = ProductoRepositoryImpl(ApiClient());
  
  late final _getAll = GetVentasUseCase(_repo);
  late final _getById = GetVentaByIdUseCase(_repo);
  late final _create = CreateVentaUseCase(_repo);
  late final _update = UpdateVentaUseCase(_repo);
  late final _delete = DeleteVentaUseCase(_repo);
  late final _confirmar = ConfirmarVentaUseCase(_repo);
  late final _getClientes = GetClientesUseCase(_clienteRepo);
  late final _getProductos = GetProductosUseCase(_productoRepo);

  // Estado
  late Future<List<VentaEntity>> _ventas;
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    _loadVentas();
  }

  void _loadVentas() {
    setState(() {
      _ventas = _getAll();
    });
  }

  // Obtener información actualizada del producto para validar stock
  Future<ProductoEntity?> _getProductoInfo(String? productoId) async {
    if (productoId == null) return null;
    try {
      final productos = await _getProductos();
      return productos.firstWhere(
        (p) => p.id == productoId,
        orElse: () => ProductoEntity(),
      );
    } catch (e) {
      return null;
    }
  }

  void _showForm({VentaEntity? venta}) {
    String? selectedClienteId = venta?.clienteId;
    final metodoPagoController = TextEditingController(text: venta?.metodoPago ?? '');
    final notasController = TextEditingController(text: venta?.notas ?? '');
    
    // Lista de productos agregados a la venta
    List<VentaDetalleDto> productosVenta = List.from(venta?.detalles ?? []);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Container(
          height: MediaQuery.of(ctx).size.height * 0.9,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Icon(
                      venta == null ? Icons.add_box : Icons.edit,
                      color: Colors.green.shade600,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      venta == null ? 'Nueva Venta' : 'Editar Venta',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pop(ctx),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Dropdown de clientes
                        _buildClienteDropdown(selectedClienteId, (clienteId) {
                          setModalState(() {
                            selectedClienteId = clienteId;
                          });
                        }),
                        const SizedBox(height: 16),
                        
                        // Método de pago
                        _buildTextField(
                          controller: metodoPagoController,
                          label: 'Método de Pago',
                          icon: Icons.payment,
                        ),
                        const SizedBox(height: 16),
                        
                        // Notas
                        _buildTextField(
                          controller: notasController,
                          label: 'Notas',
                          icon: Icons.note,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 24),
                        
                        // Sección de productos
                        _buildProductosSection(productosVenta, setModalState),
                        const SizedBox(height: 20),
                        
                        // Total
                        _buildTotalSection(productosVenta),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                // Botones de acción
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          side: BorderSide(color: Colors.grey.shade400),
                        ),
                        child: const Text('Cancelar'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          await _saveVenta(
                            ctx,
                            venta,
                            selectedClienteId,
                            metodoPagoController.text,
                            notasController.text,
                            productosVenta,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(16),
                        ),
                        child: Text(venta == null ? 'Crear' : 'Actualizar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.green.shade600),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green.shade600),
        ),
      ),
    );
  }

  Widget _buildClienteDropdown(String? selectedClienteId, Function(String?) onChanged) {
    return FutureBuilder<List<ClienteEntity>>(
      future: _getClientes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Error al cargar clientes',
                style: TextStyle(color: Colors.red.shade600),
              ),
            ),
          );
        }

        final clientes = snapshot.data!;
        
        return DropdownButtonFormField<String>(
          value: selectedClienteId,
          decoration: InputDecoration(
            labelText: 'Cliente',
            prefixIcon: Icon(Icons.person, color: Colors.green.shade600),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.green.shade600),
            ),
          ),
          items: [
            const DropdownMenuItem<String>(
              value: null,
              child: Text('Seleccionar cliente...'),
            ),
            ...clientes.map((cliente) => DropdownMenuItem<String>(
              value: cliente.id,
              child: Text(cliente.nombre ?? 'Sin nombre (${cliente.clienteCodigo})'),
            )),
          ],
          onChanged: onChanged,
        );
      },
    );
  }

  Widget _buildProductosSection(List<VentaDetalleDto> productosVenta, StateSetter setModalState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.inventory, color: Colors.green.shade600, size: 20),
            const SizedBox(width: 8),
            const Text(
              'Productos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => _showProductSelector(productosVenta, setModalState),
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Agregar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        if (productosVenta.isEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.grey.shade600),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'No hay productos agregados. Toca "Agregar" para seleccionar productos.',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
              ],
            ),
          )
        else
          ...productosVenta.asMap().entries.map((entry) {
            final index = entry.key;
            final producto = entry.value;
            return _buildProductoItem(producto, index, productosVenta, setModalState);
          }),
      ],
    );
  }

  Widget _buildProductoItem(VentaDetalleDto producto, int index, List<VentaDetalleDto> productosVenta, StateSetter setModalState) {
    return FutureBuilder<ProductoEntity?>(
      future: _getProductoInfo(producto.productoId),
      builder: (context, snapshot) {
        final productoInfo = snapshot.data;
        final stockDisponible = productoInfo?.cantidadDisponible?.toInt() ?? 0;
        final cantidadActual = producto.cantidad ?? 0;
        final excedeStock = cantidadActual > stockDisponible;
        
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          color: excedeStock ? Colors.red.shade50 : null,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        producto.nombreProducto ?? 'Producto sin nombre',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '\$${producto.precioUnitario?.toStringAsFixed(2) ?? '0.00'}',
                        style: TextStyle(
                          color: Colors.green.shade600,
                          fontSize: 12,
                        ),
                      ),
                      if (stockDisponible > 0)
                        Text(
                          'Stock: $stockDisponible ${productoInfo?.unidadMedida ?? ''}',
                          style: TextStyle(
                            color: excedeStock ? Colors.red.shade600 : Colors.grey.shade600,
                            fontSize: 11,
                            fontWeight: excedeStock ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      if (excedeStock)
                        Text(
                          '⚠️ Excede stock disponible',
                          style: TextStyle(
                            color: Colors.red.shade600,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if ((producto.cantidad ?? 0) > 1) {
                            setModalState(() {
                              final newCantidad = (producto.cantidad ?? 0) - 1;
                              productosVenta[index] = VentaDetalleDto(
                                id: producto.id,
                                productoId: producto.productoId,
                                nombreProducto: producto.nombreProducto,
                                cantidad: newCantidad,
                                precioUnitario: producto.precioUnitario,
                                subtotal: newCantidad * (producto.precioUnitario ?? 0),
                              );
                            });
                          }
                        },
                        icon: const Icon(Icons.remove, size: 16),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.grey.shade200,
                          padding: const EdgeInsets.all(4),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          '${producto.cantidad ?? 0}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: excedeStock ? Colors.red.shade600 : null,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: cantidadActual >= stockDisponible ? null : () {
                          setModalState(() {
                            final newCantidad = (producto.cantidad ?? 0) + 1;
                            productosVenta[index] = VentaDetalleDto(
                              id: producto.id,
                              productoId: producto.productoId,
                              nombreProducto: producto.nombreProducto,
                              cantidad: newCantidad,
                              precioUnitario: producto.precioUnitario,
                              subtotal: newCantidad * (producto.precioUnitario ?? 0),
                            );
                          });
                        },
                        icon: const Icon(Icons.add, size: 16),
                        style: IconButton.styleFrom(
                          backgroundColor: cantidadActual >= stockDisponible 
                              ? Colors.grey.shade300 
                              : Colors.green.shade200,
                          padding: const EdgeInsets.all(4),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${producto.subtotal?.toStringAsFixed(2) ?? '0.00'}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: excedeStock ? Colors.red.shade600 : null,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setModalState(() {
                          productosVenta.removeAt(index);
                        });
                      },
                      icon: Icon(Icons.delete, color: Colors.red.shade600, size: 16),
                      style: IconButton.styleFrom(
                        padding: const EdgeInsets.all(4),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTotalSection(List<VentaDetalleDto> productosVenta) {
    final total = productosVenta.fold<double>(
      0.0,
      (sum, producto) => sum + (producto.subtotal ?? 0),
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.attach_money, color: Colors.green.shade600),
          const SizedBox(width: 12),
          const Text(
            'Total:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(
            '\$${total.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade600,
            ),
          ),
        ],
      ),
    );
  }

  void _showProductSelector(List<VentaDetalleDto> productosVenta, StateSetter setModalState) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: MediaQuery.of(ctx).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(Icons.inventory, color: Colors.green.shade600),
                  const SizedBox(width: 12),
                  const Text(
                    'Seleccionar Productos',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(ctx),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<ProductoEntity>>(
                future: _getProductos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError || !snapshot.hasData) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error, color: Colors.red.shade600, size: 48),
                          const SizedBox(height: 16),
                          Text(
                            'Error al cargar productos',
                            style: TextStyle(color: Colors.red.shade600),
                          ),
                        ],
                      ),
                    );
                  }

                  final productos = snapshot.data!.where((p) => p.sePuedeVender == true).toList();
                  
                  if (productos.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.inventory_2_outlined, color: Colors.grey.shade400, size: 48),
                          const SizedBox(height: 16),
                          Text(
                            'No hay productos disponibles para venta',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: productos.length,
                    itemBuilder: (context, index) {
                      final producto = productos[index];
                      final yaAgregado = productosVenta.any((p) => p.productoId == producto.id);
                      final sinStock = (producto.cantidadDisponible ?? 0) <= 0;
                      
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: sinStock 
                                ? Colors.red.shade100 
                                : Colors.green.shade100,
                            child: Icon(
                              Icons.inventory_2, 
                              color: sinStock 
                                  ? Colors.red.shade600 
                                  : Colors.green.shade600,
                            ),
                          ),
                          title: Text(
                            producto.nombre ?? 'Sin nombre',
                            style: TextStyle(
                              color: sinStock ? Colors.grey.shade600 : null,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('\$${producto.precioPublico?.toStringAsFixed(2) ?? '0.00'}'),
                              if (producto.cantidadDisponible != null)
                                Text(
                                  sinStock 
                                      ? 'Sin stock disponible'
                                      : 'Disponible: ${producto.cantidadDisponible!.toStringAsFixed(0)} ${producto.unidadMedida ?? ''}',
                                  style: TextStyle(
                                    color: sinStock ? Colors.red.shade600 : Colors.grey.shade600,
                                    fontSize: 12,
                                    fontWeight: sinStock ? FontWeight.w600 : FontWeight.normal,
                                  ),
                                ),
                            ],
                          ),
                          trailing: yaAgregado
                              ? Icon(Icons.check, color: Colors.green.shade600)
                              : sinStock
                                  ? Icon(Icons.block, color: Colors.red.shade600)
                                  : IconButton(
                                      onPressed: () {
                                        setModalState(() {
                                          productosVenta.add(VentaDetalleDto(
                                            productoId: producto.id,
                                            nombreProducto: producto.nombre,
                                            cantidad: 1,
                                            precioUnitario: producto.precioPublico,
                                            subtotal: producto.precioPublico,
                                          ));
                                        });
                                        Navigator.pop(ctx);
                                      },
                                      icon: const Icon(Icons.add),
                                    ),
                          onTap: yaAgregado || sinStock ? null : () {
                            setModalState(() {
                              productosVenta.add(VentaDetalleDto(
                                productoId: producto.id,
                                nombreProducto: producto.nombre,
                                cantidad: 1,
                                precioUnitario: producto.precioPublico,
                                subtotal: producto.precioPublico,
                              ));
                            });
                            Navigator.pop(ctx);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveVenta(
    BuildContext ctx,
    VentaEntity? venta,
    String? clienteId,
    String metodoPago,
    String notas,
    List<VentaDetalleDto> productosVenta,
  ) async {
    try {
      // Validar que hay productos
      if (productosVenta.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Debe agregar al menos un producto a la venta'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      // Validar stock de todos los productos
      bool hayProblemasStock = false;
      for (final producto in productosVenta) {
        final productoInfo = await _getProductoInfo(producto.productoId);
        final stockDisponible = productoInfo?.cantidadDisponible?.toInt() ?? 0;
        final cantidadSolicitada = producto.cantidad ?? 0;
        
        if (cantidadSolicitada > stockDisponible) {
          hayProblemasStock = true;
          break;
        }
      }

      if (hayProblemasStock) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Algunos productos exceden el stock disponible. Por favor revisa las cantidades.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final total = productosVenta.fold<double>(
        0.0,
        (sum, producto) => sum + (producto.subtotal ?? 0),
      );

      if (venta == null) {
        await _create(
          VentaEntity(
            clienteId: clienteId,
            metodoPago: metodoPago.trim().isEmpty ? null : metodoPago.trim(),
            notas: notas.trim().isEmpty ? null : notas.trim(),
            total: total,
            detalles: productosVenta,
          ),
        );
      } else {
        await _update(venta.id!, {
          'clienteId': clienteId,
          'metodoPago': metodoPago.trim().isEmpty ? null : metodoPago.trim(),
          'notas': notas.trim().isEmpty ? null : notas.trim(),
          'total': total,
          'detalles': productosVenta.map((e) => e.toJson()).toList(),
        });
      }

      if (!mounted) return;
      Navigator.pop(ctx);
      _loadVentas();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            venta == null 
              ? 'Venta creada exitosamente' 
              : 'Venta actualizada exitosamente',
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _deleteVenta(String id, String clienteId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.orange.shade600),
            const SizedBox(width: 12),
            const Text('Confirmar eliminación'),
          ],
        ),
        content: Text('¿Seguro que querés eliminar la venta de cliente "$clienteId"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await _delete(id);
        if (!mounted) return;
        _loadVentas();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Venta eliminada exitosamente'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al eliminar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _confirmarVenta(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green.shade600),
            const SizedBox(width: 12),
            const Text('Confirmar Venta'),
          ],
        ),
        content: const Text('¿Seguro que querés confirmar esta venta?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Confirmar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await _confirmar(id);
        if (!mounted) return;
        _loadVentas();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Venta confirmada exitosamente'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al confirmar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showVentaDetalle(VentaEntity venta) async {
    try {
      final full = await _getById(venta.id!);

      if (!mounted) return;
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (ctx) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.point_of_sale,
                        color: Colors.green.shade600,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Venta #${full.id?.substring(0, 8) ?? 'N/A'}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (full.clienteId != null)
                            Text(
                              'Cliente: ${full.clienteId!}',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 16,
                              ),
                            ),
                        ],
                      ),
                    ),
                    _buildEstadoChip(full.estado ?? 'pendiente'),
                  ],
                ),
                const SizedBox(height: 24),
                if (full.total != null)
                  _buildInfoCard(
                    'Total',
                    '\$${full.total!.toStringAsFixed(2)}',
                    Icons.attach_money,
                    Colors.green,
                  ),
                const SizedBox(height: 16),
                if (full.metodoPago != null && full.metodoPago!.isNotEmpty)
                  _buildInfoCard(
                    'Método de Pago',
                    full.metodoPago!,
                    Icons.payment,
                    Colors.blue,
                  ),
                const SizedBox(height: 16),
                if (full.notas != null && full.notas!.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.note, color: Colors.grey.shade600),
                            const SizedBox(width: 8),
                            Text(
                              'Notas',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          full.notas!,
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.pop(ctx),
                        icon: const Icon(Icons.close),
                        label: const Text('Cerrar'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    if (full.estado == 'pendiente') ...[
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(ctx);
                            _confirmarVenta(full.id!);
                          },
                          icon: const Icon(Icons.check),
                          label: const Text('Confirmar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade600,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(16),
                          ),
                        ),
                      ),
                    ] else ...[
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(ctx);
                            _showForm(venta: full);
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text('Editar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade600,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(16),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al cargar detalles: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildEstadoChip(String estado) {
    Color color;
    switch (estado.toLowerCase()) {
      case 'confirmada':
        color = Colors.green;
        break;
      case 'cancelada':
        color = Colors.red;
        break;
      default:
        color = Colors.orange;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        estado.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: color.withOpacity(0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: color,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVentaCard(VentaEntity venta) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showVentaDetalle(venta),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.point_of_sale,
                  color: Colors.green.shade600,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Venta #${venta.id?.substring(0, 8) ?? 'N/A'}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    if (venta.clienteId != null && venta.clienteId!.isNotEmpty)
                      Text(
                        'Cliente: ${venta.clienteId!}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (venta.total != null) ...[
                          Icon(Icons.attach_money, size: 14, color: Colors.green),
                          const SizedBox(width: 2),
                          Flexible(
                            child: Text(
                              '\$${venta.total!.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        if (venta.metodoPago != null) ...[
                          Icon(Icons.payment, size: 14, color: Colors.blue),
                          const SizedBox(width: 2),
                          Flexible(
                            child: Text(
                              venta.metodoPago!,
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  _buildEstadoChip(venta.estado ?? 'pendiente'),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (venta.estado == 'pendiente')
                        IconButton(
                          icon: Icon(Icons.check, color: Colors.green.shade600),
                          onPressed: () => _confirmarVenta(venta.id!),
                          tooltip: 'Confirmar',
                        ),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.green.shade600),
                        onPressed: () => _showForm(venta: venta),
                        tooltip: 'Editar',
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red.shade600),
                        onPressed: () => _deleteVenta(
                          venta.id!,
                          venta.clienteId ?? 'Sin cliente',
                        ),
                        tooltip: 'Eliminar',
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Ventas',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar ventas...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) {
                setState(() {
                  _searchTerm = value.toLowerCase();
                });
              },
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<VentaEntity>>(
        future: _ventas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error al cargar ventas',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.grey.shade600),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _loadVentas,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.point_of_sale_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No hay ventas',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Comenzá registrando tu primera venta',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ],
              ),
            );
          }

          final ventas = snapshot.data!.where((v) {
            if (_searchTerm.isEmpty) return true;
            final clienteId = v.clienteId?.toLowerCase() ?? '';
            final metodoPago = v.metodoPago?.toLowerCase() ?? '';
            final notas = v.notas?.toLowerCase() ?? '';
            final estado = v.estado?.toLowerCase() ?? '';
            return clienteId.contains(_searchTerm) || 
                   metodoPago.contains(_searchTerm) ||
                   notas.contains(_searchTerm) ||
                   estado.contains(_searchTerm);
          }).toList();

          if (ventas.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No se encontraron ventas',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Probá con otro término de búsqueda',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => _loadVentas(),
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 80),
              itemCount: ventas.length,
              itemBuilder: (context, index) {
                return _buildVentaCard(ventas[index]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showForm(),
        backgroundColor: Colors.green.shade600,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Nueva Venta'),
      ),
    );
  }
}
