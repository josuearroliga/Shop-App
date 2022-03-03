import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  final List<Product> loadedProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
      ),
      //Renders only the items on screen to improve perrf.
      body: ProductsGrid(),
    );
  }
}
