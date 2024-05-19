import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models/venta.dart';
import 'package:myapp/services/venta_services.dart';

class VentaDetailScreen extends StatefulWidget {
  const VentaDetailScreen({super.key});

  @override
  State<VentaDetailScreen> createState() => _VentaDetailScreenState();
}

class _VentaDetailScreenState extends State<VentaDetailScreen> {

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _valueController = TextEditingController();
  String _selectedPaymentMethod = 'Efectivo';
  String selectedClient = '';
  DateTime _selectedDate = DateTime.now();
  DateTime _currentDate = DateTime.now();
  final VentaService services = VentaService();

  @override
  void dispose() {
    _nameController.dispose();
    _valueController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Venta'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nombre del producto'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresar el nombre';
                    }
                    return null;
                  },
                ),
        
                const SizedBox(height: 16.0),
                
                TextFormField(
                  controller: _valueController,
                  decoration: const InputDecoration(labelText: 'Valor'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresar el valor';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16.0),


                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<String>.empty();
                    }
                    return ['Client 1', 'Client 2', 'Client 3']
                        .where((client) => client.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                  },
                  onSelected: (client) {
                    setState(() {
                      selectedClient=client;
                    });
                  },
                ),
                
                const SizedBox(height: 16.0),
        
                Column(
                  children: [
                    ListTile(
                      title: const Text('Efectivo'),
                      leading: Radio<String>(
                        value: 'Efectivo',
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Tarjeta de débito'),
                      leading: Radio<String>(
                        value: 'Tarjeta debito',
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Tarjeta de crédito'),
                      leading: Radio<String>(
                        value: 'Tarjeta credito',
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16.0),
        
                TextButton(
                  onPressed: ()  async {

                    final datePicker = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2030),
                    );

                    if (datePicker != null) {
                      setState(() {
                        _currentDate = datePicker;
                        _selectedDate = datePicker;
                      });
                    }

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Fecha: ${DateFormat('dd/MM/yyyy').format(_currentDate)}'),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),

                const SizedBox(height: 16.0),
        
                ElevatedButton(
                  onPressed: () async {
                    // Implementar la lógica para procesar el pago
                    if (_formKey.currentState!.validate()){  
                      
                      if (!selectedClient.trim().isNotEmpty) {
                        showDialog(
                          context: context, 
                          builder: (context) => AlertDialog(
                            title: const Text('Advertencia'),
                            content: const Text('Por favor Escribe el nombre de un cliente para seleccionarlo.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cerrar'),
                              ),
                            ],
                          )
                        ); 
                      } else {
                        Venta sale = Venta(
                          productName: _nameController.text,
                          value: int.parse(_valueController.text),
                          client: selectedClient,
                          paymentMethod: _selectedPaymentMethod,
                          paymentDate:  DateFormat('yyyy-MM-dd').format(_currentDate),
                        );

                        try{ 
                          await services.agregarVenta(sale);

                          if (context.mounted){
                            showDialog(
                              context: context, 
                              builder: (context) => AlertDialog(
                                title: const Text('Excelente!'),
                                content: const Text('Venta creada'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cerrar'),
                                  ),
                                ],
                              )
                            );
                          }

                        } catch (e) {

                          if (context.mounted){
                            showDialog(
                              context: context, 
                              builder: (context) => AlertDialog(
                                title: const Text('Error'),
                                content: Text(e.toString()),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cerrar'),
                                  ),
                                ],
                              )
                            );
                          }

                        }


                        
                      }
                    }
                  },
                  child: const Text('Guardar'),
                ),
        
              ],
            ),
          ),
        ),
      ),
    );
  }
}




