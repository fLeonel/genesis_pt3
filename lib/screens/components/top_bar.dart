import 'package:flutter/material.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final String currentPath;
  final Function(String path) onNavigate;

  const TopBar({
    super.key,
    required this.currentPath,
    required this.onNavigate,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? get currentModule {
    final path = widget.currentPath;
    if (path.startsWith('/inventario')) return 'Inventario';
    if (path.startsWith('/ventas')) return 'Ventas';
    if (path.startsWith('/clientes')) return 'Clientes';
    if (path.startsWith('/restaurante')) return 'Restaurante';
    return null;
  }

  Map<String, List<Map<String, dynamic>>> get menus => {
    'Inventario': [
      {'label': 'Dashboard', 'path': '/inventario'},
      {'label': 'Productos', 'path': '/inventario/productos'},
      {
        'label': 'Configuración',
        'submenus': [
          {'label': 'Categorías', 'path': '/inventario/categorias'},
          {'label': 'Combos', 'path': '/inventario/combos'},
          {'label': 'Recetas', 'path': '/inventario/recetas'},
          {'label': 'Bodegas', 'path': '/inventario/bodegas'},
        ],
      },
    ],
    'Ventas': [
      {'label': 'Dashboard', 'path': '/ventas/dashboard'},
      {'label': 'Historial', 'path': '/ventas/historial'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final module = currentModule;
    if (module == null) return const SizedBox();

    final activeMenus = menus[module] ?? [];

    return AppBar(
      centerTitle: true,
      title: Text(module, style: const TextStyle(fontWeight: FontWeight.bold)),
      leading: IconButton(
        icon: const Icon(Icons.home_rounded),
        onPressed: () => widget.onNavigate('/'),
      ),
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
        ),
      ],
    );
  }
}

class ModuleDrawer extends StatelessWidget {
  final String module;
  final List<Map<String, dynamic>> menus;
  final Function(String path) onNavigate;

  const ModuleDrawer({
    super.key,
    required this.module,
    required this.menus,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                module,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ...menus.map((menu) {
            if (menu.containsKey('submenus')) {
              final subs = menu['submenus'] as List;
              return ExpansionTile(
                title: Text(menu['label'] as String),
                children: subs.map<Widget>((sub) {
                  return ListTile(
                    title: Text(sub['label'] as String),
                    onTap: () {
                      Navigator.pop(context);
                      Future.delayed(const Duration(milliseconds: 200), () {
                        onNavigate(sub['path'] as String);
                      });
                    },
                  );
                }).toList(),
              );
            } else {
              return ListTile(
                title: Text(menu['label'] as String),
                onTap: () {
                  Navigator.pop(context);
                  Future.delayed(const Duration(milliseconds: 200), () {
                    onNavigate(menu['path'] as String);
                  });
                },
              );
            }
          }),
        ],
      ),
    );
  }
}
