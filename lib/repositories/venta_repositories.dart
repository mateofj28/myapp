import 'package:myapp/db.dart';
import 'package:myapp/models/venta.dart';
import 'package:sqflite/sqflite.dart';

class VentaRepository {
  
  final DatabaseHelper _databaseHelper = DatabaseHelper();


  Future<void> crearVenta(Venta venta) async {
    final db = await _databaseHelper.db;
    try {
      await db!.insert(
        'sales',
        venta.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e){
      return Future.error(e);
    }
  }

  Future<List<Venta>> obtenerTodasLasVentas() async {
    final db = await _databaseHelper.db;

    final List<Map<String, dynamic>> mapasVentas = await db!.query('sales');
    return List.generate(mapasVentas.length, (i) {
      return Venta(
        id: mapasVentas[i]['id'],
        productName: mapasVentas[i]['productName'],
        value: mapasVentas[i]['value'],
        client: mapasVentas[i]['client'],
        paymentMethod: mapasVentas[i]['paymentMethod'],
        paymentDate: mapasVentas[i]['paymentDate'],
      );
    });
  }

  Future<void> actualizarVenta(Venta venta) async {
    final db = await _databaseHelper.db;
    await db!.update('sales', venta.toMap(), where: 'id = ?', whereArgs: [venta.id]);
  }

  Future<void> eliminarVenta(int id) async {
    final db = await _databaseHelper.db;
    await db!.delete('sales', where: 'id = ?', whereArgs: [id]);
  }
}
