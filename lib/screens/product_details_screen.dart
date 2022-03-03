import 'package:flutter/material.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  //final String title;

  static const routeName = '/product-details';

  @override
  Widget build(BuildContext context) {
    //Recepting the date in the route
    String ProductId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context)
        .items
        .firstWhere((prod) => prod.id == ProductId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
    );
  }
}
