import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

import '../screens/product_details_screen.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    //Add a listener to provider
    //We stop listening for changes as we do not need to rebuild
    //the whole thing, we use the consumer approach for specificity.
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return GridTile(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetailsScreen.routeName, arguments: product.id);
        },
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ),
      ),

      //To make its border rounded.
      footer: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTileBar(
          backgroundColor: Colors.blueGrey[900],
          leading: IconButton(
            iconSize: 22,
            onPressed: () {
              product.toggleFavStatus();
            },
            color: Theme.of(context).primaryColorLight,
            //We are only rebuilding this widget, since the main provider
            //that is up is set not to listen.
            icon: Consumer<Product>(
              builder: (ctx, product, child) => Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
            },
            color: Theme.of(context).primaryColorDark,
          ),
        ),
      ),
    );
  }
}
