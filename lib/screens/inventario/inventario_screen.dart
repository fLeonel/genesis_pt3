import 'package:flutter/material.dart';
import 'package:genesis_pt3/screens/components/top_bar.dart';
import 'package:genesis_pt3/screens/inventario/bodegas/bodega_screen.dart';
import 'package:genesis_pt3/screens/inventario/categorias/categoria_screen.dart';
import 'package:genesis_pt3/screens/inventario/productos/productos_screen.dart';

class InventarioScreen extends StatefulWidget {
  const InventarioScreen({super.key});

  @override
  State<InventarioScreen> createState() => _InventarioScreenState();
}

class _InventarioScreenState extends State<InventarioScreen> {
  String currentPath = '/inventario';

  void navigate(String path) {
    if (path == '/') {
      Navigator.pop(context);
    } else if (path.endsWith('/inventario/categorias')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CategoriaScreen()),
      );
    } else if (path.endsWith('/inventario/bodegas')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const BodegaScreen()),
      );
    } else if (path.endsWith('/inventario/productos')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder:(_) => const ProductosScreen()),
        );
    } else {
      setState(() => currentPath = path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(currentPath: currentPath, onNavigate: navigate),
      endDrawer: ModuleDrawer(
        module: 'Inventario',
        menus: const [
          {'label': 'Dashboard', 'path': '/inventario'},
          {'label': 'Productos', 'path': '/inventario/productos'},
          {'label': 'Categorias', 'path': '/inventario/categorias'},
          {
            'label': 'Configuración',
            'submenus': [
              {'label': 'Combos', 'path': '/inventario/combos'},
              {'label': 'Recetas', 'path': '/inventario/recetas'},
              {'label': 'Bodegas', 'path': '/inventario/bodegas'},
            ],
          },
        ],
        onNavigate: navigate,
      ),
      body: const Center(
        child: Text(
          'Inventario — seleccioná una opción del menú',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
