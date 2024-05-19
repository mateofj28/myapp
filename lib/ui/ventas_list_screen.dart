import 'package:flutter/material.dart';
import 'package:myapp/ui/venta_detail_screen.dart';
import 'package:myapp/widgets/dismissible_ventas.dart';

class VentasListScreen extends StatefulWidget {
  const VentasListScreen({super.key});

  @override
  State<VentasListScreen> createState() => _VentasListScreenState();
}

class _VentasListScreenState extends State<VentasListScreen> {
  List<Map<String, String>> items = [
  {'name': 'Item 1', 'description': 'This is the first item.'},
  {'name': 'Item 2', 'description': 'This is the second item.'},
  {'name': 'Item 3', 'description': 'This is the third item.'},
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ventas'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return DismissibleVentas(
            name: items[index]['name']!,
            description: items[index]['description']!,
            onEdit: () {
              // Handle edit action
            },
            onDelete: () {
              // Handle delete
              setState(() {
                items.removeAt(index);
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle add action
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const VentaDetailScreen()),
          );

        },
        child: const Icon(Icons.add),
      ),
    );
  }
}



