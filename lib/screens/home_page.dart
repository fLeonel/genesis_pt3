import 'package:flutter/material.dart';
import 'package:genesis_pt3/screens/components/module_card.dart';
import 'package:genesis_pt3/screens/inventario/inventario_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cazuela Chapina')),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          ModuleCard(
            title: 'Inventario',
            icon: Icons.inventory_2_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const InventarioScreen()),
              );
            },
          ),
          ModuleCard(title: 'Ventas', icon: Icons.point_of_sale, onTap: () {}),
          ModuleCard(
            title: 'Clientes',
            icon: Icons.people_alt_rounded,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
