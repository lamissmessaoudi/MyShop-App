import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  // void addOrder(List<CartItem> cartProducts, double total) {
  //   _orders.insert(
  //     0,
  //     OrderItem(
  //       id: DateTime.now().toString(),
  //       amount: total,
  //       products: cartProducts,
  //       dateTime: DateTime.now(),
  //     ),
  //   );
  //   notifyListeners();
  // }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url = 'https://flutter-update-3d404.firebaseio.com/orders.json';
    final timeStamp = DateTime.now();

    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  })
              .toList(),
        }));

    final newOrder = OrderItem(
      id: json.decode(response.body)['name'],
      amount: total,
      products: cartProducts,
      dateTime: timeStamp,
    );

    _orders.add(newOrder);
    notifyListeners();
  }
}
