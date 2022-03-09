import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartScreen extends StatelessWidget {
//Adding the route.
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
//Addign a provider for cart
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Products:"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  //This calculation is made in the class via getter.
                  Chip(
                    label: Text('\$${cart.totalAmount}'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
