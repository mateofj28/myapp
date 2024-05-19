class Venta {
  late int? id;
  late String productName;
  late int value;
  late String client;
  late String paymentMethod;
  late String paymentDate;

  Venta({this.id, required this.productName, required this.value, required this.client, required this.paymentMethod, required this.paymentDate});

  Map<String, dynamic> toMap() {
    return {
      "productName": productName,
      "value": value,
      "client": client,
      "paymentMethod": paymentMethod,
      "paymentDate": paymentDate
    };
  }

  @override
  String toString() {
    return 'Sale {id: $id, name: $productName, value: $value, client: $client, paymentMethod: $paymentMethod, paymentDate: $paymentDate}';
  }


  
}

