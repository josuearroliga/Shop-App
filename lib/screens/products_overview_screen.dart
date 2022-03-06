import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../providers/product.dart';
import '../widgets/products_grid.dart';

enum filterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatelessWidget {
  final List<Product> loadedProducts = [];

  @override
  Widget build(BuildContext context) {
    final changeFavs = Provider.of<Products>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (filterOptions selectedValue) {
              if (selectedValue == filterOptions.Favorites) {
                changeFavs.showFavoritesOnly();
              } else {
                changeFavs.showAll();
              }
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: filterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('All products'),
                value: filterOptions.All,
              ),
            ],
          )
        ],
      ),
      //Renders only the items on screen to improve perrf.
      body: ProductsGrid(),
    );
  }
}
