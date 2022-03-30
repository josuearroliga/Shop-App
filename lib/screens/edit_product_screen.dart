import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-prod';
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  //Manage whcih input is focused.
  final _priceFocusNode = FocusNode();
  final _DescFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  //This is to interact with the from details, this way we can save its elements.
  final _form = GlobalKey<FormState>();
  var isLoading = false;

//This varioable is createdf to store the textformfiel data once we click on save.
  var _editedProduct =
      Product(id: null, title: '', description: '', price: 0, imageUrl: '');

//Creating a map to store the values that we will give to the form when empty.
  var _initValue = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  //DidchangeDependencies controller
  var isInit = true;

  //We need to dispose the focus nodes after using them since the remain
  //in memory even if were nto using them.
  @override
  void initState() {
    // TODO: implement initState
    //Adding this to properly set a listener to the image focus node.
    _imageUrlFocusNode.addListener(_imageUrlListener);
    super.initState();
  }

  @override
  void dispose() {
    //All this should be disposed once we have started listening, if not
    //it will remian in memory.
    _imageUrlFocusNode.dispose();
    _DescFocusNode.dispose();
    _priceFocusNode.dispose();
    _imageUrlController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  //This is created to control the preloaded product, before build runs.
  @override
  void didChangeDependencies() {
    if (isInit) {
      //We gather the prodId received when the navigator pushed this page
      // and convert it to string.
      final productId = ModalRoute.of(context).settings.arguments as String;
      //Checking if we received an argument.
      if (productId != null) {
        //Initialize the dummy product here
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        //We assign the edited product values to the map s we can transfer to
        //the from text fields.
        _initValue = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    //Make it run only once by setting isInit to false.
    isInit = false;
    super.didChangeDependencies();
  }

//If we loose focus we update the UI immediately.
  void _imageUrlListener() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  //Saves when we press the save button.
  //From onFieldSubmitted
  void _saveForm() {
    //Validating fields
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      isLoading = true;
    });

    print(isLoading);
    //This one calls the add product method inside the products provider to gather the data and create
    //the nnew product.

    //Check if were updating or creating a new item.
    //If we have an id, then its an edit, if not is a new item.
    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      Provider.of<Products>(context, listen: false)
          .addProduct(_editedProduct)
          .then((_) {
        setState(() {
          isLoading = false;
        });
//Go to previous page.
        Navigator.of(context).pop();
        print(isLoading);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit or Add Product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save_outlined),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initValue['title'],
                      decoration: InputDecoration(labelText: 'Title:'),
                      textInputAction: TextInputAction.next,
                      //This states what the return button should look l
                      //We tell Flutte when tyhis first title is submitted he can jump to
                      //the provided focus node which si the price.
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      //This will control how the form validates the data.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please add a valid Title';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite,
                            title: value,
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imageUrl: _editedProduct.imageUrl);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValue['price'],
                      decoration: InputDecoration(labelText: 'Price:'),
                      //This states what the return button should look like.
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_DescFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please add a valid price';
                        }
                        if (double.tryParse(value) < 0) {
                          return 'Please add a value higher than zero';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: double.parse(value),
                            imageUrl: _editedProduct.imageUrl);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValue['description'],
                      decoration: InputDecoration(labelText: 'Description:'),
                      maxLines: 3,
                      //textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      focusNode: _DescFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please add a valid description';
                        }
                        if (value.length < 10) {
                          return 'Enter a description with nmore than 10 characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite,
                            title: _editedProduct.title,
                            description: value,
                            price: _editedProduct.price,
                            imageUrl: _editedProduct.imageUrl);
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 8, right: 10, left: 10),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Enter a URL')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: "Image URL"),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please add a valid Image URL';
                              }
                              if (!value.startsWith('http') ||
                                  !value.startsWith('https')) {
                                return 'Please enter a valid Image URL';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                  id: _editedProduct.id,
                                  isFavorite: _editedProduct.isFavorite,
                                  title: _editedProduct.title,
                                  description: _editedProduct.description,
                                  price: _editedProduct.price,
                                  imageUrl: value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

//
// Expanded(
//   child: TextFormField(
//     decoration: InputDecoration(labelText: 'Image URL'),
//     keyboardType: TextInputType.url,
//     textInputAction: TextInputAction.done,
//     controller: _imageUrlController,
//     onEditingComplete: () {
//       setState(() {});
//     },
//   )
// )

//https://upload.wikimedia.org/wikipedia/commons/b/be/A_very_small_book.png
