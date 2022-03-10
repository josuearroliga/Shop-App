import 'package:flutter/material.dart';

import '../widgets/cart_item.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../providers/orders.dart';

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
                //Adding the fact to evenly aling each element in the row.
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  //This calculation is made in the class via getter.
                  Chip(
                      backgroundColor: Theme.of(context).primaryColorLight,
                      label: Text(
                        '\$${cart.totalAmount}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          //color: Theme.of(context).primaryColor,
                        ),
                      )),
                  FlatButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.values.toList(), cart.totalAmount);
                      cart.clear();
                    },
                    child: Text(
                      'Order Now',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, i) => CartItem(
                  //Needs to convert this to a valued list since it returned only a mao.
                  cart.items.values.toList()[i].id,
                  //We pass the keys so the receptor context can know which
                  //item we want to delete.
                  cart.items.keys.toList()[i],
                  cart.items.values.toList()[i].price,
                  cart.items.values.toList()[i].quantity,
                  cart.items.values.toList()[i].title),
            ),
          ),
        ],
      ),
    );
  }
}
