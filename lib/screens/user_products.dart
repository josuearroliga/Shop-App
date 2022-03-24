import 'package:flutter/material.dart';
import '../providers/products.dart';

import '../screens/edit_product_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    //Adding the listener.
    final productsData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your products!'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Container(
        height: double.infinity,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: productsData.items.length,
          //Always takes 2 arguments, the ctx and the index, like the for loop
          itemBuilder: (_, i) {
            return UserProductItem(productsData.items[i].id,
                productsData.items[i].title, productsData.items[i].imageUrl);
          },
        ),
      ),
    );
  }
}
