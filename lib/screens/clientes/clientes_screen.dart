import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesis_pt3/application/useCases/clientes/create_cliente.dart';
import 'package:genesis_pt3/application/useCases/clientes/delete_cliente.dart';
import 'package:genesis_pt3/application/useCases/clientes/get_clientes.dart';
import 'package:genesis_pt3/application/useCases/clientes/get_cliente_by_id.dart';
import 'package:genesis_pt3/application/useCases/clientes/update_cliente.dart';
import 'package:genesis_pt3/domain/Entities/clientes/cliente_entity.dart';
import 'package:genesis_pt3/infrastructure/http/api_client.dart';
import 'package:genesis_pt3/infrastructure/implements/cliente_repository_impl.dart';

class ClientesScreen extends StatefulWidget {
  const ClientesScreen({super.key});

  @override
  State<ClientesScreen> createState() => _ClientesScreenState();
}

class _ClientesScreenState extends State<ClientesScreen> {
  late final _repo = ClienteRepositoryImpl(ApiClient());
  late final _getAll = GetClientesUseCase(_repo);
  late final _getById = GetClienteByIdUseCase(_repo);
  late final _create = CreateClienteUseCase(_repo);
  late final _update = UpdateClienteUseCase(_repo);
  late final _delete = DeleteClienteUseCase(_repo);

  late Future<List<ClienteEntity>> _clientes;
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    _loadClientes();
  }

  void _loadClientes() {
    setState(() {
      _clientes = _getAll();
    });
  }

  void _showForm({ClienteEntity? cliente}) {
    final codigoController = TextEditingController(text: cliente?.clienteCodigo ?? '');
    final nombreController = TextEditingController(text: cliente?.nombre ?? '');
    final telefonoController = TextEditingController(text: cliente?.telefono ?? '');
    final correoController = TextEditingController(text: cliente?.correo ?? '');
    final nitController = TextEditingController(text: cliente?.nit ?? '');
    final direccionController = TextEditingController(text: cliente?.direccion ?? '');

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    cliente == null ? Icons.add_box : Icons.edit,
                    color: Colors.purple.shade600,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    cliente == null ? 'Nuevo Cliente' : 'Editar Cliente',
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
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: codigoController,
                              label: 'Código Cliente',
                              icon: Icons.badge,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 2,
                            child: _buildTextField(
                              controller: nombreController,
                              label: 'Nombre Completo',
                              icon: Icons.person,
                              required: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: telefonoController,
                              label: 'Teléfono',
                              icon: Icons.phone,
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildTextField(
                              controller: correoController,
                              label: 'Correo Electrónico',
                              icon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: nitController,
                        label: 'NIT',
                        icon: Icons.receipt_long,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: direccionController,
                        label: 'Dirección',
                        icon: Icons.location_on,
                        maxLines: 3,
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
                        if (nombreController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('El nombre es obligatorio'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        try {
                          if (cliente == null) {
                            await _create(
                              ClienteEntity(
                                clienteCodigo: codigoController.text.trim().isEmpty 
                                    ? null 
                                    : codigoController.text.trim(),
                                nombre: nombreController.text.trim(),
                                telefono: telefonoController.text.trim().isEmpty 
                                    ? null 
                                    : telefonoController.text.trim(),
                                correo: correoController.text.trim().isEmpty 
                                    ? null 
                                    : correoController.text.trim(),
                                nit: nitController.text.trim().isEmpty 
                                    ? null 
                                    : nitController.text.trim(),
                                direccion: direccionController.text.trim().isEmpty 
                                    ? null 
                                    : direccionController.text.trim(),
                              ),
                            );
                          } else {
                            await _update(cliente.id!, {
                              'nombre': nombreController.text.trim(),
                              'telefono': telefonoController.text.trim().isEmpty 
                                  ? null 
                                  : telefonoController.text.trim(),
                              'correo': correoController.text.trim().isEmpty 
                                  ? null 
                                  : correoController.text.trim(),
                              'nit': nitController.text.trim().isEmpty 
                                  ? null 
                                  : nitController.text.trim(),
                              'direccion': direccionController.text.trim().isEmpty 
                                  ? null 
                                  : direccionController.text.trim(),
                            });
                          }

                          if (!mounted) return;
                          Navigator.pop(ctx);
                          _loadClientes();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                cliente == null 
                                  ? 'Cliente creado exitosamente' 
                                  : 'Cliente actualizado exitosamente',
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
                        backgroundColor: Colors.purple.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                      ),
                      child: Text(cliente == null ? 'Crear' : 'Actualizar'),
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
        prefixIcon: Icon(icon, color: Colors.purple.shade600),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.purple.shade600),
        ),
      ),
    );
  }

  void _deleteCliente(String id, String nombre) async {
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
        content: Text('¿Seguro que querés eliminar el cliente \"$nombre\"?'),
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
        _loadClientes();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cliente eliminado exitosamente'),
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

  void _showClienteDetalle(ClienteEntity cliente) async {
    try {
      final full = await _getById(cliente.id!);

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
                        color: Colors.purple.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.purple.shade600,
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
                          if (full.clienteCodigo != null && full.clienteCodigo!.isNotEmpty)
                            Text(
                              'Código: ${full.clienteCodigo!}',
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
                if (full.telefono != null && full.telefono!.isNotEmpty)
                  _buildInfoCard(
                    'Teléfono',
                    full.telefono!,
                    Icons.phone,
                    Colors.green,
                  ),
                const SizedBox(height: 12),
                if (full.correo != null && full.correo!.isNotEmpty)
                  _buildInfoCard(
                    'Correo Electrónico',
                    full.correo!,
                    Icons.email,
                    Colors.blue,
                  ),
                const SizedBox(height: 12),
                if (full.nit != null && full.nit!.isNotEmpty)
                  _buildInfoCard(
                    'NIT',
                    full.nit!,
                    Icons.receipt_long,
                    Colors.orange,
                  ),
                const SizedBox(height: 16),
                if (full.direccion != null && full.direccion!.isNotEmpty)
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
                            Icon(Icons.location_on, color: Colors.grey.shade600),
                            const SizedBox(width: 8),
                            Text(
                              'Dirección',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          full.direccion!,
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
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(ctx);
                          _showForm(cliente: full);
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text('Editar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple.shade600,
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
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClienteCard(ClienteEntity cliente) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showClienteDetalle(cliente),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.person,
                  color: Colors.purple.shade600,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cliente.nombre ?? 'Sin nombre',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    if (cliente.clienteCodigo != null && cliente.clienteCodigo!.isNotEmpty)
                      Text(
                        'Código: ${cliente.clienteCodigo!}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (cliente.telefono != null && cliente.telefono!.isNotEmpty) ...[
                          Icon(Icons.phone, size: 14, color: Colors.green),
                          const SizedBox(width: 2),
                          Flexible(
                            child: Text(
                              cliente.telefono!,
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
                        if (cliente.correo != null && cliente.correo!.isNotEmpty) ...[
                          Icon(Icons.email, size: 14, color: Colors.blue),
                          const SizedBox(width: 2),
                          Flexible(
                            child: Text(
                              cliente.correo!,
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
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.purple.shade600),
                    onPressed: () => _showForm(cliente: cliente),
                    tooltip: 'Editar',
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red.shade600),
                    onPressed: () => _deleteCliente(
                      cliente.id!,
                      cliente.nombre ?? 'Sin nombre',
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
          'Clientes',
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
                hintText: 'Buscar clientes...',
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
      body: FutureBuilder<List<ClienteEntity>>(
        future: _clientes,
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
                    'Error al cargar clientes',
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
                    onPressed: _loadClientes,
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
                    Icons.people_alt_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No hay clientes',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Comenzá registrando tu primer cliente',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ],
              ),
            );
          }

          final clientes = snapshot.data!.where((c) {
            if (_searchTerm.isEmpty) return true;
            final nombre = c.nombre?.toLowerCase() ?? '';
            final codigo = c.clienteCodigo?.toLowerCase() ?? '';
            final telefono = c.telefono?.toLowerCase() ?? '';
            final correo = c.correo?.toLowerCase() ?? '';
            final nit = c.nit?.toLowerCase() ?? '';
            return nombre.contains(_searchTerm) || 
                   codigo.contains(_searchTerm) ||
                   telefono.contains(_searchTerm) ||
                   correo.contains(_searchTerm) ||
                   nit.contains(_searchTerm);
          }).toList();

          if (clientes.isEmpty) {
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
                    'No se encontraron clientes',
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
            onRefresh: () async => _loadClientes(),
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 80),
              itemCount: clientes.length,
              itemBuilder: (context, index) {
                return _buildClienteCard(clientes[index]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showForm(),
        backgroundColor: Colors.purple.shade600,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Cliente'),
      ),
    );
  }
}