import 'package:flutter/material.dart';
import 'package:genesis_pt3/application/useCases/inventario/bodegas/create_bodega.dart';
import 'package:genesis_pt3/application/useCases/inventario/bodegas/delete_bodega.dart';
import 'package:genesis_pt3/application/useCases/inventario/bodegas/get_bodega.dart';
import 'package:genesis_pt3/application/useCases/inventario/bodegas/get_bodega_by_id.dart';
import 'package:genesis_pt3/application/useCases/inventario/bodegas/update_bodega.dart';
import 'package:genesis_pt3/domain/Entities/inventario/bodegas/bodega_entity.dart';
import 'package:genesis_pt3/infrastructure/http/api_client.dart';
import 'package:genesis_pt3/infrastructure/implements/bodega_repository_impl.dart';

class BodegaScreen extends StatefulWidget {
  const BodegaScreen({super.key});

  @override
  State<BodegaScreen> createState() => _BodegaScreenState();
}

class _BodegaScreenState extends State<BodegaScreen> {
  late final _repo = BodegaRepositoryImpl(ApiClient());
  late final _getAll = GetBodegasUseCase(_repo);
  late final _getById = GetBodegaByIdUseCase(_repo);
  late final _create = CreateBodegaUseCase(_repo);
  late final _update = UpdateBodegaUseCase(_repo);
  late final _delete = DeleteBodegaUseCase(_repo);

  late Future<List<BodegaEntity>> _bodegas;

  @override
  void initState() {
    super.initState();
    _loadBodegas();
  }

  void _loadBodegas() {
    setState(() {
      _bodegas = _getAll();
    });
  }

  void _showForm({BodegaEntity? bodega}) {
    final nameController = TextEditingController(text: bodega?.nombre ?? '');
    final descController = TextEditingController(
      text: bodega?.descripcion ?? '',
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(bodega == null ? 'Nueva Bodega' : 'Editar Bodega'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (bodega == null) {
                await _create(
                  BodegaEntity(
                    nombre: nameController.text,
                    descripcion: descController.text,
                  ),
                );
              } else {
                await _update(bodega.id!, {
                  'nombre': nameController.text,
                  'descripcion': descController.text,
                });
              }

              if (!mounted) return;
              Navigator.pop(ctx);
              _loadBodegas();
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _deleteBodega(String id) async {
    final confirm = await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar Bodega'),
        content: const Text('¿Seguro que querés eliminar esta bodega?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _delete(id);
      if (!mounted) return;
      _loadBodegas();
    }
  }

  void _openBodegaDetalle(BodegaEntity bodega) async {
    final full = await _getById(bodega.id!);

    if (!mounted) return;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(full.nombre ?? 'Sin nombre'),
        content: Text(full.descripcion ?? 'Sin descripción'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cerrar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _showForm(bodega: full);
            },
            child: const Text('Editar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bodegas')),
      body: FutureBuilder<List<BodegaEntity>>(
        future: _bodegas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay bodegas'));
          }

          final bodegas = snapshot.data!;
          return ListView.builder(
            itemCount: bodegas.length,
            itemBuilder: (context, index) {
              final bodega = bodegas[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(bodega.nombre ?? 'Sin nombre'),
                  subtitle: Text(bodega.descripcion ?? ''),
                  onTap: () => _openBodegaDetalle(bodega),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showForm(bodega: bodega),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteBodega(bodega.id!),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showForm(),
        label: const Text('Nueva'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
