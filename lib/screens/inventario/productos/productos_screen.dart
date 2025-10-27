import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesis_pt3/application/useCases/inventario/productos/create_producto.dart';
import 'package:genesis_pt3/application/useCases/inventario/productos/delete_producto.dart';
import 'package:genesis_pt3/application/useCases/inventario/productos/get_productos.dart';
import 'package:genesis_pt3/application/useCases/inventario/productos/get_producto_by_id.dart';
import 'package:genesis_pt3/application/useCases/inventario/productos/update_producto.dart';
import 'package:genesis_pt3/domain/Entities/inventario/productos/producto_entity.dart';
import 'package:genesis_pt3/infrastructure/http/api_client.dart';
import 'package:genesis_pt3/infrastructure/implements/producto_repository_impl.dart';

class ProductosScreen extends StatefulWidget {
  const ProductosScreen({super.key});

  @override
  State<ProductosScreen> createState() => _ProductosScreenState();
}

class _ProductosScreenState extends State<ProductosScreen> {
  late final _repo = ProductoRepositoryImpl(ApiClient());
  late final _getAll = GetProductosUseCase(_repo);
  late final _getById = GetProductoByIdUseCase(_repo);
  late final _create = CreateProductoUseCase(_repo);
  late final _update = UpdateProductoUseCase(_repo);
  late final _delete = DeleteProductoUseCase(_repo);

  late Future<List<ProductoEntity>> _productos;
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    _loadProductos();
  }

  void _loadProductos() {
    setState(() {
      _productos = _getAll();
    });
  }

  void _showForm({ProductoEntity? producto}) {
    final nameController = TextEditingController(text: producto?.nombre ?? '');
    final descController = TextEditingController(text: producto?.descripcion ?? '');
    final precioController = TextEditingController(
      text: producto?.precioPublico?.toString() ?? '',
    );
    final costoController = TextEditingController(
      text: producto?.costoUnitario?.toString() ?? '',
    );
    final unidadController = TextEditingController(text: producto?.unidadMedida ?? '');
    final cantidadController = TextEditingController(
      text: producto?.cantidadDisponible?.toString() ?? '',
    );

    bool sePuedeVender = producto?.sePuedeVender ?? true;
    bool sePuedeComprar = producto?.sePuedeComprar ?? true;
    bool esFabricado = producto?.esFabricado ?? false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
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
          child: StatefulBuilder(
            builder: (context, setModalState) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      producto == null ? Icons.add_box : Icons.edit,
                      color: Colors.blue.shade600,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      producto == null ? 'Nuevo Producto' : 'Editar Producto',
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
                      children: [
                        _buildTextField(
                          controller: nameController,
                          label: 'Nombre del Producto',
                          icon: Icons.inventory_2,
                          required: true,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: descController,
                          label: 'Descripción',
                          icon: Icons.description,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                controller: precioController,
                                label: 'Precio Público',
                                icon: Icons.attach_money,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,2}'),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildTextField(
                                controller: costoController,
                                label: 'Costo Unitario',
                                icon: Icons.money_off,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,2}'),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                controller: unidadController,
                                label: 'Unidad de Medida',
                                icon: Icons.straighten,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildTextField(
                                controller: cantidadController,
                                label: 'Cantidad Disponible',
                                icon: Icons.inventory,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,2}'),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        _buildSwitchTile(
                          title: 'Se puede vender',
                          subtitle: 'Permitir la venta de este producto',
                          icon: Icons.shopping_cart,
                          value: sePuedeVender,
                          onChanged: (value) {
                            setModalState(() {
                              sePuedeVender = value;
                            });
                          },
                        ),
                        _buildSwitchTile(
                          title: 'Se puede comprar',
                          subtitle: 'Permitir la compra de este producto',
                          icon: Icons.shopping_bag,
                          value: sePuedeComprar,
                          onChanged: (value) {
                            setModalState(() {
                              sePuedeComprar = value;
                            });
                          },
                        ),
                        _buildSwitchTile(
                          title: 'Es fabricado',
                          subtitle: 'Este producto se fabrica internamente',
                          icon: Icons.build,
                          value: esFabricado,
                          onChanged: (value) {
                            setModalState(() {
                              esFabricado = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
                          if (nameController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('El nombre es obligatorio'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          try {
                            if (producto == null) {
                              await _create(
                                ProductoEntity(
                                  nombre: nameController.text.trim(),
                                  descripcion: descController.text.trim(),
                                  precioPublico: double.tryParse(precioController.text),
                                  costoUnitario: double.tryParse(costoController.text),
                                  unidadMedida: unidadController.text.trim(),
                                  cantidadDisponible: double.tryParse(cantidadController.text),
                                  sePuedeVender: sePuedeVender,
                                  sePuedeComprar: sePuedeComprar,
                                  esFabricado: esFabricado,
                                ),
                              );
                            } else {
                              await _update(producto.id!, {
                                'nombre': nameController.text.trim(),
                                'descripcion': descController.text.trim(),
                                'precioPublico': double.tryParse(precioController.text),
                                'costoUnitario': double.tryParse(costoController.text),
                                'unidadMedida': unidadController.text.trim(),
                                'cantidadDisponible': double.tryParse(cantidadController.text),
                                'sePuedeVender': sePuedeVender,
                                'sePuedeComprar': sePuedeComprar,
                                'esFabricado': esFabricado,
                              });
                            }

                            if (!mounted) return;
                            Navigator.pop(ctx);
                            _loadProductos();

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  producto == null 
                                    ? 'Producto creado exitosamente' 
                                    : 'Producto actualizado exitosamente',
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
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade600,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(16),
                        ),
                        child: Text(producto == null ? 'Crear' : 'Actualizar'),
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
    bool required = false,
    int maxLines = 1,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: label + (required ? ' *' : ''),
        prefixIcon: Icon(icon, color: Colors.blue.shade600),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade600),
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
        secondary: Icon(icon, color: Colors.blue.shade600),
        value: value,
        onChanged: onChanged,
        activeColor: Colors.blue.shade600,
      ),
    );
  }

  void _deleteProducto(String id, String nombre) async {
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
        content: Text('¿Seguro que querés eliminar el producto \"$nombre\"?'),
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
        _loadProductos();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Producto eliminado exitosamente'),
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

  void _showProductoDetalle(ProductoEntity producto) async {
    try {
      final full = await _getById(producto.id!);

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
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.inventory_2,
                        color: Colors.blue.shade600,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            full.nombre ?? 'Sin nombre',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (full.descripcion != null && full.descripcion!.isNotEmpty)
                            Text(
                              full.descripcion!,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 16,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                if (full.precioPublico != null || full.costoUnitario != null)
                  Row(
                    children: [
                      if (full.precioPublico != null)
                        Expanded(
                          child: _buildInfoCard(
                            'Precio Público',
                            '\$${full.precioPublico!.toStringAsFixed(2)}',
                            Icons.attach_money,
                            Colors.green,
                          ),
                        ),
                      if (full.precioPublico != null && full.costoUnitario != null)
                        const SizedBox(width: 12),
                      if (full.costoUnitario != null)
                        Expanded(
                          child: _buildInfoCard(
                            'Costo Unitario',
                            '\$${full.costoUnitario!.toStringAsFixed(2)}',
                            Icons.money_off,
                            Colors.orange,
                          ),
                        ),
                    ],
                  ),
                if (full.precioPublico != null || full.costoUnitario != null)
                  const SizedBox(height: 12),
                Row(
                  children: [
                    if (full.cantidadDisponible != null)
                      Expanded(
                        child: _buildInfoCard(
                          'Stock',
                          '${full.cantidadDisponible!.toStringAsFixed(1)} ${full.unidadMedida ?? 'uds'}',
                          Icons.inventory,
                          Colors.blue,
                        ),
                      ),
                    if (full.cantidadDisponible != null && full.unidadMedida != null)
                      const SizedBox(width: 12),
                    if (full.unidadMedida != null)
                      Expanded(
                        child: _buildInfoCard(
                          'Unidad',
                          full.unidadMedida!,
                          Icons.straighten,
                          Colors.purple,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildStatusChip(
                      'Venta',
                      full.sePuedeVender == true,
                      Icons.shopping_cart,
                    ),
                    const SizedBox(width: 8),
                    _buildStatusChip(
                      'Compra',
                      full.sePuedeComprar == true,
                      Icons.shopping_bag,
                    ),
                    const SizedBox(width: 8),
                    _buildStatusChip(
                      'Fabricado',
                      full.esFabricado == true,
                      Icons.build,
                    ),
                  ],
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
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(ctx);
                          _showForm(producto: full);
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text('Editar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade600,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),
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

  Widget _buildInfoCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String label, bool isActive, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive ? Colors.green.withOpacity(0.3) : Colors.grey.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: isActive ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.green : Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(ProductoEntity producto) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showProductoDetalle(producto),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.inventory_2,
                  color: Colors.blue.shade600,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      producto.nombre ?? 'Sin nombre',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    if (producto.descripcion != null && producto.descripcion!.isNotEmpty)
                      Text(
                        producto.descripcion!,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (producto.precioPublico != null) ...[
                          Icon(Icons.attach_money, size: 14, color: Colors.green),
                          const SizedBox(width: 2),
                          Text(
                            '\$${producto.precioPublico!.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        if (producto.cantidadDisponible != null) ...[
                          Icon(Icons.inventory, size: 14, color: Colors.blue),
                          const SizedBox(width: 2),
                          Text(
                            '${producto.cantidadDisponible!.toStringAsFixed(1)}',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
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
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue.shade600),
                    onPressed: () => _showForm(producto: producto),
                    tooltip: 'Editar',
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red.shade600),
                    onPressed: () => _deleteProducto(
                      producto.id!,
                      producto.nombre ?? 'Sin nombre',
                    ),
                    tooltip: 'Eliminar',
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
          'Productos',
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
                hintText: 'Buscar productos...',
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
      body: FutureBuilder<List<ProductoEntity>>(
        future: _productos,
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
                    'Error al cargar productos',
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
                    onPressed: _loadProductos,
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
                    Icons.inventory_2_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No hay productos',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Comenzá creando tu primer producto',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ],
              ),
            );
          }

          final productos = snapshot.data!.where((p) {
            if (_searchTerm.isEmpty) return true;
            final nombre = p.nombre?.toLowerCase() ?? '';
            final descripcion = p.descripcion?.toLowerCase() ?? '';
            return nombre.contains(_searchTerm) || descripcion.contains(_searchTerm);
          }).toList();

          if (productos.isEmpty) {
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
                    'No se encontraron productos',
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
            onRefresh: () async => _loadProductos(),
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 80),
              itemCount: productos.length,
              itemBuilder: (context, index) {
                return _buildProductCard(productos[index]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showForm(),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Producto'),
      ),
    );
  }
}