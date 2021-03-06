import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/a/aa/T-shirt_serigraphie_1_Couleur.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get itemFavorites {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

//This works like a constructor, but instead, what we return is
//a copy of the original class/object.
//Filtering the favorites to only display those.
  List<Product> get items {
    return _items.toList();
  }
  // void showFavoritesOnly() {
  //   _showFavsOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavsOnly = false;
  //   notifyListeners();
  // }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://flutter-project-2c9e2-default-rtdb.firebaseio.com/products.json');
    try {
      //Stoere the await data into a variable.
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageURL': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );

      //Will let other widgets know if we made changes in this class.
      final newProduct = Product(
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        //The response is the originated ID in the server, we assign it to the
        //local version of the item as well.
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
      //We can manipulate the response, which in this case is the ID that
      //the server creates for this item.

    } catch (error) {
      print(error);
      throw error;
    }

    //_items.add(value);
  }

  //Creating a method to find by id in argument.
  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  //Adding update method.
  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    _items[prodIndex] = newProduct;
    notifyListeners();
  }

  void removeProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
  //Elegir favoritos

}
