import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../providers/product.dart';
import '../providers/cart.dart';

class OrderItem {
  String id;
  double amount;
  List<CartItem> products;
  DateTime time;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.time});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            amount: total,
            products: cartProducts,
            time: DateTime.now()));
    notifyListeners();
  }
}
