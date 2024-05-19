import 'package:myapp/models/venta.dart';
import 'package:myapp/repositories/venta_repositories.dart';

class VentaService {
  final VentaRepository _ventaRepository = VentaRepository();

  Future<void> agregarVenta(Venta venta) async {
    await _ventaRepository.crearVenta(venta);
  }

  Future<List<Venta>> obtenerVentas() async {
    return await _ventaRepository.obtenerTodasLasVentas();
  }

  Future<void> modificarVenta(Venta venta) async {
    await _ventaRepository.actualizarVenta(venta);
  }

  Future<void> removerVenta(int id) async {
    await _ventaRepository.eliminarVenta(id);
  }
}
