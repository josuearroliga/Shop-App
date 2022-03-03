import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/product_item.dart';
import '../screens/products_overview_screen.dart';
import '../providers/product.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //We explicitly tell dart that we are expecting changes on this
    //class only.
    final productsData = Provider.of<Products>(context);
    //
    final products = productsData.items;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemCount: products.length,
      padding: const EdgeInsets.all(10.0),
      //We use value to avid issues when more items add up to the lis
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(),
        //Grid dstructer, how many columns.
      ),
    );
  }
}
