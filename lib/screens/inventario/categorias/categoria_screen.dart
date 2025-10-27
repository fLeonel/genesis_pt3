import 'package:flutter/material.dart';
import 'package:genesis_pt3/domain/Entities/inventario/categorias/categoria_entity.dart';
import 'package:genesis_pt3/infrastructure/http/api_client.dart';
import 'package:genesis_pt3/infrastructure/implements/categoria_repository_impl.dart';

class CategoriaScreen extends StatefulWidget {
  const CategoriaScreen({super.key});

  @override
  State<CategoriaScreen> createState() => _CategoriaScreenState();
}

class _CategoriaScreenState extends State<CategoriaScreen> {
  final _repo = CategoriaRepositoryImpl(ApiClient());
  late Future<List<CategoriaEntity>> _categorias;

  @override
  void initState() {
    super.initState();
    _loadCategorias();
  }

  void _loadCategorias() {
    setState(() {
      _categorias = _repo.getCategorias();
    });
  }

  void _showForm({CategoriaEntity? categoria}) {
    final nameController = TextEditingController(text: categoria?.nombre ?? '');
    final descController = TextEditingController(
      text: categoria?.descripcion ?? '',
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(categoria == null ? 'Nueva Categoría' : 'Editar Categoría'),
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
              if (categoria == null) {
                await _repo.createCategoria(
                  CategoriaEntity(
                    nombre: nameController.text,
                    descripcion: descController.text,
                  ),
                );
              } else {
                await _repo.updateCategoria(categoria.id!, {
                  'nombre': nameController.text,
                  'descripcion': descController.text,
                });
              }

              if (!mounted) return;
              Navigator.pop(ctx);
              _loadCategorias();
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _deleteCategoria(String id) async {
    final confirm = await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar Categoría'),
        content: const Text('¿Seguro que querés eliminar esta categoría?'),
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
      await _repo.deleteCategoria(id);
      if (!mounted) return;
      _loadCategorias();
    }
  }

  void _openCategoriaDetalle(CategoriaEntity categoria) async {
    final full = await _repo.getCategoriaById(categoria.id!);

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
              _showForm(categoria: full);
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
      appBar: AppBar(title: const Text('Categorías')),
      body: FutureBuilder<List<CategoriaEntity>>(
        future: _categorias,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay categorías'));
          }

          final categorias = snapshot.data!;
          return ListView.builder(
            itemCount: categorias.length,
            itemBuilder: (context, index) {
              final categoria = categorias[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(categoria.nombre ?? 'Sin nombre'),
                  subtitle: Text(categoria.descripcion ?? ''),
                  onTap: () => _openCategoriaDetalle(categoria),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showForm(categoria: categoria),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteCategoria(categoria.id!),
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
