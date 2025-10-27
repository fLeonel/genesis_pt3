import 'package:flutter/material.dart';
import 'package:genesis_pt3/application/useCases/ventas/create_venta.dart';
import 'package:genesis_pt3/application/useCases/ventas/delete_venta.dart';
import 'package:genesis_pt3/application/useCases/ventas/get_ventas.dart';
import 'package:genesis_pt3/application/useCases/ventas/get_venta_by_id.dart';
import 'package:genesis_pt3/application/useCases/ventas/update_venta.dart';
import 'package:genesis_pt3/application/useCases/ventas/confirmar_venta.dart';
import 'package:genesis_pt3/domain/Entities/ventas/venta_entity.dart';
import 'package:genesis_pt3/infrastructure/http/api_client.dart';
import 'package:genesis_pt3/infrastructure/implements/venta_repository_impl.dart';

class VentasScreen extends StatefulWidget {
  const VentasScreen({super.key});

  @override
  State<VentasScreen> createState() => _VentasScreenState();
}

class _VentasScreenState extends State<VentasScreen> {
  late final _repo = VentaRepositoryImpl(ApiClient());
  late final _getAll = GetVentasUseCase(_repo);
  late final _getById = GetVentaByIdUseCase(_repo);
  late final _create = CreateVentaUseCase(_repo);
  late final _update = UpdateVentaUseCase(_repo);
  late final _delete = DeleteVentaUseCase(_repo);
  late final _confirmar = ConfirmarVentaUseCase(_repo);

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

  void _showForm({VentaEntity? venta}) {
    final clienteController = TextEditingController(text: venta?.clienteId ?? '');
    final metodoPagoController = TextEditingController(text: venta?.metodoPago ?? '');
    final notasController = TextEditingController(text: venta?.notas ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: MediaQuery.of(ctx).size.height * 0.8,
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
                    children: [
                      _buildTextField(
                        controller: clienteController,
                        label: 'ID del Cliente',
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: metodoPagoController,
                        label: 'Método de Pago',
                        icon: Icons.payment,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: notasController,
                        label: 'Notas',
                        icon: Icons.note,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.green.shade200),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info, color: Colors.green.shade600),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'La gestión de productos de la venta se realizará en una versión futura',
                                style: TextStyle(
                                  color: Colors.green.shade800,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
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
                        try {
                          if (venta == null) {
                            await _create(
                              VentaEntity(
                                clienteId: clienteController.text.trim().isEmpty 
                                    ? null 
                                    : clienteController.text.trim(),
                                metodoPago: metodoPagoController.text.trim().isEmpty 
                                    ? null 
                                    : metodoPagoController.text.trim(),
                                notas: notasController.text.trim().isEmpty 
                                    ? null 
                                    : notasController.text.trim(),
                              ),
                            );
                          } else {
                            await _update(venta.id!, {
                              'clienteId': clienteController.text.trim().isEmpty 
                                  ? null 
                                  : clienteController.text.trim(),
                              'metodoPago': metodoPagoController.text.trim().isEmpty 
                                  ? null 
                                  : metodoPagoController.text.trim(),
                              'notas': notasController.text.trim().isEmpty 
                                  ? null 
                                  : notasController.text.trim(),
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
        content: Text('¿Seguro que querés eliminar la venta de cliente \"$clienteId\"?'),
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