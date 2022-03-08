import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});
}

class Cart with ChangeNotifier {
//To load the cart products
  Map<String, CartItem> _items;

  //Getter
  Map<String, CartItem> get items {
    return {..._items};
  }

//To add products
  void addItem(String productId, double price, String title) {
//Checking if the product has been added before.
    if (_items.containsKey(productId)) {
      //.... change the quantiy
      _items.update(
        productId,
        (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            quantity: existingCartItem.quantity + 1,
            price: existingCartItem.price),
      );
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
  }
}
