import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../providers/product.dart';
import '../widgets/products_grid.dart';

enum filterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  final List<Product> loadedProducts = [];
  var isFavorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (filterOptions selectedValue) {
              setState(() {
                if (selectedValue == filterOptions.Favorites) {
                  isFavorite = true;
                } else {
                  isFavorite = false;
                }
              });
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
      body: ProductsGrid(isFavorite),
    );
  }
}
