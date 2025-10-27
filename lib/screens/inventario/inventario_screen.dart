import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:genesis_pt3/screens/components/top_bar.dart';
import 'package:genesis_pt3/screens/inventario/bodegas/bodega_screen.dart';
import 'package:genesis_pt3/screens/inventario/categorias/categoria_screen.dart';
import 'package:genesis_pt3/screens/inventario/combos/combos_screen.dart';
import 'package:genesis_pt3/screens/inventario/productos/productos_screen.dart';
import 'package:genesis_pt3/application/useCases/inventario/productos/get_productos.dart';
import 'package:genesis_pt3/application/useCases/inventario/bodegas/get_bodega.dart';
import 'package:genesis_pt3/domain/Entities/inventario/productos/producto_entity.dart';
import 'package:genesis_pt3/domain/Entities/inventario/bodegas/bodega_entity.dart';
import 'package:genesis_pt3/domain/Entities/inventario/categorias/categoria_entity.dart';
import 'package:genesis_pt3/infrastructure/http/api_client.dart';
import 'package:genesis_pt3/infrastructure/implements/producto_repository_impl.dart';
import 'package:genesis_pt3/infrastructure/implements/bodega_repository_impl.dart';
import 'package:genesis_pt3/infrastructure/implements/categoria_repository_impl.dart';
import 'package:genesis_pt3/screens/inventario/recetas/recetas_screen.dart';

class InventarioScreen extends StatefulWidget {
  const InventarioScreen({super.key});

  @override
  State<InventarioScreen> createState() => _InventarioScreenState();
}

class _InventarioScreenState extends State<InventarioScreen> {
  String currentPath = '/inventario';
  
  // Repositorios y casos de uso
  late final _productoRepo = ProductoRepositoryImpl(ApiClient());
  late final _bodegaRepo = BodegaRepositoryImpl(ApiClient());
  late final _categoriaRepo = CategoriaRepositoryImpl(ApiClient());
  
  late final _getProductos = GetProductosUseCase(_productoRepo);
  late final _getBodegas = GetBodegasUseCase(_bodegaRepo);
  
  // Datos para el dashboard
  List<ProductoEntity> _productos = [];
  List<BodegaEntity> _bodegas = [];
  List<CategoriaEntity> _categorias = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    try {
      setState(() => _isLoading = true);
      
      // Cargamos los datos de forma secuencial para evitar problemas de tipos
      final productos = await _getProductos().catchError((_) => <ProductoEntity>[]);
      final bodegas = await _getBodegas().catchError((_) => <BodegaEntity>[]);
      final categorias = await _categoriaRepo.getCategorias().catchError((_) => <CategoriaEntity>[]);
      
      if (mounted) {
        setState(() {
          _productos = productos;
          _bodegas = bodegas;
          _categorias = categorias;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

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
    } else if (path.endsWith('/inventario/recetas')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder:(_) => const RecetasScreen()),
        );
    } else if (path.endsWith('/inventario/combos')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder:(_) => const CombosScreen()),
        );
    } else {
      setState(() => currentPath = path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadDashboardData,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Encabezado de bienvenida
                    _buildWelcomeHeader(),
                    const SizedBox(height: 24),
                    
                    // Cards de estadísticas rápidas
                    _buildQuickStatsCards(),
                    const SizedBox(height: 24),
                    
                    // Gráficos
                    _buildChartsSection(),
                    const SizedBox(height: 24),
                    
                    // Accesos rápidos
                    _buildQuickActions(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade600, Colors.blue.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '¡Bienvenido al Inventario!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Gestiona tus productos, categorías y bodegas de forma eficiente',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.inventory_2,
              color: Colors.white,
              size: 48,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatsCards() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Productos',
            _productos.length.toString(),
            Icons.inventory_2,
            Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            'Categorías',
            _categorias.length.toString(),
            Icons.category,
            Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            'Bodegas',
            _bodegas.length.toString(),
            Icons.warehouse,
            Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Análisis de Inventario',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            // Gráfico de productos por categoría
            Expanded(
              child: _buildProductsByCategoryChart(),
            ),
            const SizedBox(width: 16),
            // Gráfico de stock
            Expanded(
              child: _buildStockChart(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProductsByCategoryChart() {
    final categoryStats = <String, int>{};
    
    for (final producto in _productos) {
      final categoria = _categorias.firstWhere(
        (c) => c.id == producto.categoriaId,
        orElse: () => CategoriaEntity(nombre: 'Sin categoría'),
      );
      final categoryName = categoria.nombre;
      categoryStats[categoryName] = (categoryStats[categoryName] ?? 0) + 1;
    }

    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Productos por Categoría',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: categoryStats.isEmpty
                ? const Center(
                    child: Text(
                      'No hay datos para mostrar',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                      sections: categoryStats.entries.map((entry) {
                        final index = categoryStats.keys.toList().indexOf(entry.key);
                        final colors = [
                          Colors.blue,
                          Colors.green,
                          Colors.orange,
                          Colors.purple,
                          Colors.red,
                        ];
                        return PieChartSectionData(
                          color: colors[index % colors.length],
                          value: entry.value.toDouble(),
                          title: '${entry.value}',
                          radius: 50,
                          titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockChart() {
    final productosConStock = _productos.where((p) => p.cantidadDisponible != null).toList();
    
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Niveles de Stock',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: productosConStock.isEmpty
                ? const Center(
                    child: Text(
                      'No hay datos de stock',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: productosConStock.map((p) => p.cantidadDisponible!).reduce((a, b) => a > b ? a : b) * 1.2,
                      barTouchData: BarTouchData(enabled: false),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              if (value.toInt() < productosConStock.length) {
                                final producto = productosConStock[value.toInt()];
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    (producto.nombre?.length ?? 0) > 6 
                                        ? '${producto.nombre?.substring(0, 6)}...'
                                        : producto.nombre ?? '',
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                );
                              }
                              return const Text('');
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(fontSize: 10),
                              );
                            },
                          ),
                        ),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: productosConStock.asMap().entries.map((entry) {
                        return BarChartGroupData(
                          x: entry.key,
                          barRods: [
                            BarChartRodData(
                              toY: entry.value.cantidadDisponible!,
                              color: Colors.blue.shade400,
                              width: 16,
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Accesos Rápidos',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                'Nuevo Producto',
                'Agregar producto al inventario',
                Icons.add_box,
                Colors.blue,
                () => navigate('/inventario/productos'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                'Gestionar Categorías',
                'Organizar productos por categoría',
                Icons.category,
                Colors.green,
                () => navigate('/inventario/categorias'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                'Configurar Bodegas',
                'Administrar espacios de almacenamiento',
                Icons.warehouse,
                Colors.orange,
                () => navigate('/inventario/bodegas'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
