import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:genesis_pt3/screens/inventario/inventario_screen.dart';
import 'package:genesis_pt3/screens/ventas/ventas_screen.dart';
import 'package:genesis_pt3/screens/clientes/clientes_screen.dart';
import 'package:genesis_pt3/domain/Entities/dashboard/dashboard_entity.dart';
import 'package:genesis_pt3/application/useCases/dashboard/get_dashboard_data.dart';
import 'package:genesis_pt3/infrastructure/implements/mock_dashboard_repository_impl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Repositorio y caso de uso
  // Temporalmente usando mock repository para demostración
  // Para usar datos reales, reemplazar con: DashboardRepositoryImpl(ApiClient())
  late final _dashboardRepo = MockDashboardRepository();
  late final _getDashboardData = GetDashboardDataUseCase(_dashboardRepo);
  
  // Estado de los datos
  DashboardEntity? _dashboardData;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });
      
      final data = await _getDashboardData();
      
      if (mounted) {
        setState(() {
          _dashboardData = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadDashboardData,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header moderno con gradiente
                _buildHeader(context),
                
                // Mostrar loading, error o contenido
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.all(40),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (_error != null)
                  _buildErrorWidget()
                else ...[
                  // Estadísticas rápidas con datos reales
                  _buildQuickStats(context),
                  
                  // Gráficos de análisis
                  _buildAnalyticsSection(context),
                  
                  // Módulos principales
                  _buildMainModules(context, isTablet),
                  
                  // Accesos rápidos
                  _buildQuickActions(context),
                ],
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade600,
            Colors.purple.shade600,
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.restaurant,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Cazuela Chapina',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Sistema de Gestión Integral',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.wb_sunny_outlined,
                    color: Colors.white.withOpacity(0.9),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '¡Buen día! Gestiona tu negocio de manera eficiente',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    final data = _dashboardData;
    
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Resumen del día',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              // En pantallas pequeñas, usar columna en lugar de fila
              if (constraints.maxWidth < 600) {
                return Column(
                  children: [
                    _buildStatCard(
                      title: 'Ventas Diarias',
                      value: 'Q${data?.ventasDiarias?.toStringAsFixed(2) ?? '0.00'}',
                      icon: Icons.trending_up,
                      color: Colors.green,
                      subtitle: 'Hoy',
                    ),
                    const SizedBox(height: 12),
                    _buildStatCard(
                      title: 'Ventas Mensuales',
                      value: 'Q${data?.ventasMensuales?.toStringAsFixed(2) ?? '0.00'}',
                      icon: Icons.calendar_month,
                      color: Colors.blue,
                      subtitle: 'Este mes',
                    ),
                    const SizedBox(height: 12),
                    _buildStatCard(
                      title: 'Utilidad Total',
                      value: 'Q${data?.utilidadTotal?.toStringAsFixed(2) ?? '0.00'}',
                      icon: Icons.attach_money,
                      color: Colors.purple,
                      subtitle: 'Ganancia',
                    ),
                  ],
                );
              } else {
                return Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        title: 'Ventas Diarias',
                        value: 'Q${data?.ventasDiarias?.toStringAsFixed(2) ?? '0.00'}',
                        icon: Icons.trending_up,
                        color: Colors.green,
                        subtitle: 'Hoy',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        title: 'Ventas Mensuales',
                        value: 'Q${data?.ventasMensuales?.toStringAsFixed(2) ?? '0.00'}',
                        icon: Icons.calendar_month,
                        color: Colors.blue,
                        subtitle: 'Este mes',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        title: 'Utilidad Total',
                        value: 'Q${data?.utilidadTotal?.toStringAsFixed(2) ?? '0.00'}',
                        icon: Icons.attach_money,
                        color: Colors.purple,
                        subtitle: 'Ganancia',
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const Spacer(),
              Icon(Icons.more_vert, color: Colors.grey.shade400, size: 16),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainModules(BuildContext context, bool isTablet) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Módulos principales',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isTablet ? 4 : 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.1,
            children: [
              _buildEnhancedModuleCard(
                title: 'Inventario',
                subtitle: 'Gestión de productos',
                icon: Icons.inventory_2_rounded,
                color: Colors.blue,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const InventarioScreen()),
                  );
                },
              ),
              _buildEnhancedModuleCard(
                title: 'Ventas',
                subtitle: 'Punto de venta',
                icon: Icons.point_of_sale,
                color: Colors.green,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const VentasScreen()),
                  );
                },
              ),
              _buildEnhancedModuleCard(
                title: 'Clientes',
                subtitle: 'Base de datos',
                icon: Icons.people_alt_rounded,
                color: Colors.purple,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ClientesScreen()),
                  );
                },
              ),
              _buildEnhancedModuleCard(
                title: 'Reportes',
                subtitle: 'Análisis y datos',
                icon: Icons.analytics_rounded,
                color: Colors.orange,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Módulo de Reportes - Próximamente'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedModuleCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color.withOpacity(0.8),
                      color,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Accesos rápidos',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildQuickActionCard(
                  title: 'Nueva Venta',
                  icon: Icons.add_shopping_cart,
                  color: Colors.green,
                  onTap: () {},
                ),
                const SizedBox(width: 12),
                _buildQuickActionCard(
                  title: 'Agregar Producto',
                  icon: Icons.add_box,
                  color: Colors.blue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const InventarioScreen()),
                    );
                  },
                ),
                const SizedBox(width: 12),
                _buildQuickActionCard(
                  title: 'Ver Reportes',
                  icon: Icons.bar_chart,
                  color: Colors.orange,
                  onTap: () {},
                ),
                const SizedBox(width: 12),
                _buildQuickActionCard(
                  title: 'Configuración',
                  icon: Icons.settings,
                  color: Colors.grey,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.red.shade200),
        ),
        child: Column(
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red.shade400,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'Error al cargar los datos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _error ?? 'Ocurrió un error inesperado',
              style: TextStyle(
                fontSize: 14,
                color: Colors.red.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _loadDashboardData,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade400,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsSection(BuildContext context) {
    final data = _dashboardData;
    
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Análisis y Reportes',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          
          // Productos más vendidos
          if (data?.tamalesMasVendidos != null && data!.tamalesMasVendidos!.isNotEmpty)
            _buildTopProductsCard(data.tamalesMasVendidos!),
          
          const SizedBox(height: 16),
          
          // Ventas por horario y proporción picante
          LayoutBuilder(
            builder: (context, constraints) {
              // En pantallas pequeñas, usar columna en lugar de fila
              if (constraints.maxWidth < 800) {
                return Column(
                  children: [
                    if (data?.bebidasPorHorario != null && data!.bebidasPorHorario!.isNotEmpty)
                      _buildSalesByTimeCard(data.bebidasPorHorario!),
                    
                    const SizedBox(height: 16),
                    
                    if (data?.proporcionPicante != null)
                      _buildSpicyProportionCard(data!.proporcionPicante!),
                  ],
                );
              } else {
                return Row(
                  children: [
                    if (data?.bebidasPorHorario != null && data!.bebidasPorHorario!.isNotEmpty)
                      Expanded(child: _buildSalesByTimeCard(data.bebidasPorHorario!)),
                    
                    const SizedBox(width: 16),
                    
                    if (data?.proporcionPicante != null)
                      Expanded(child: _buildSpicyProportionCard(data!.proporcionPicante!)),
                  ],
                );
              }
            },
          ),
          
          const SizedBox(height: 16),
          
          // Desperdicio de materia prima
          if (data?.desperdicioMateriaPrima != null)
            _buildWasteCard(data!.desperdicioMateriaPrima!),
        ],
      ),
    );
  }

  Widget _buildTopProductsCard(List<TamalMasVendido> productos) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.local_fire_department, color: Colors.orange, size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Productos Más Vendidos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...productos.take(3).map((producto) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    producto.nombre ?? 'Producto sin nombre',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${producto.cantidad}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade700,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildSalesByTimeCard(List<BebidaPorHorario> ventas) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ventas por Horario',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: ventas.map((v) => v.ventas ?? 0).reduce((a, b) => a > b ? a : b) * 1.2,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() < ventas.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              ventas[value.toInt()].hora ?? '',
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
                          'Q${value.toInt()}',
                          style: const TextStyle(fontSize: 10),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                barGroups: ventas.asMap().entries.map((entry) {
                  return BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value.ventas ?? 0,
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

  Widget _buildSpicyProportionCard(ProporcionPicante proporcion) {
    final total = (proporcion.picante ?? 0) + (proporcion.noPicante ?? 0);
    
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Proporción Picante',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: total > 0 ? PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 40,
                sections: [
                  PieChartSectionData(
                    color: Colors.red.shade400,
                    value: (proporcion.picante ?? 0).toDouble(),
                    title: '${proporcion.picante}',
                    radius: 50,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    color: Colors.green.shade400,
                    value: (proporcion.noPicante ?? 0).toDouble(),
                    title: '${proporcion.noPicante}',
                    radius: 50,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ) : const Center(
              child: Text(
                'No hay datos',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.red.shade400,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text('Picante', style: TextStyle(fontSize: 12)),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.green.shade400,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text('No Picante', style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWasteCard(double desperdicio) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: desperdicio > 0 ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              desperdicio > 0 ? Icons.warning : Icons.check_circle,
              color: desperdicio > 0 ? Colors.red : Colors.green,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Desperdicio de Materia Prima',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desperdicio > 0 
                      ? 'Q${desperdicio.toStringAsFixed(2)} en desperdicios'
                      : 'Sin desperdicios hoy',
                  style: TextStyle(
                    fontSize: 14,
                    color: desperdicio > 0 ? Colors.red.shade600 : Colors.green.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*
INSTRUCCIONES PARA USAR DATOS REALES DEL BACKEND:

1. Reemplaza MockDashboardRepository() en la línea 24 con:
   DashboardRepositoryImpl(ApiClient())

2. Agrega los imports necesarios:
   import 'package:genesis_pt3/infrastructure/implements/dashboard_repository_impl.dart';
   import 'package:genesis_pt3/infrastructure/http/api_client.dart';

3. Asegúrate de que tu backend esté ejecutándose en la URL configurada en ApiClient

Los datos del backend deben tener esta estructura JSON:
{
  "ventasDiarias": 0,
  "ventasMensuales": 163.0,
  "tamalesMasVendidos": [
    {"nombre": "Tamal Dulce", "cantidad": 11},
    {"nombre": "Chocolate Mediano", "cantidad": 11},
    {"nombre": "Tamal Nacional", "cantidad": 2}
  ],
  "bebidasPorHorario": [
    {"hora": "11:00", "ventas": 36.0},
    {"hora": "14:00", "ventas": 61.0},
    {"hora": "19:00", "ventas": 40.0},
    {"hora": "22:00", "ventas": 26.0}
  ],
  "proporcionPicante": {"picante": 0, "noPicante": 7},
  "utilidadTotal": 76.0,
  "desperdicioMateriaPrima": 0
}
*/
