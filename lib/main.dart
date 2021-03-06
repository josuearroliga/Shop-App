import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../screens/orders_screen.dart';
import '../screens/user_products.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import './screens/product_details_screen.dart';
import './screens/products_overview_screen.dart';
import './widgets/product_item.dart';
import 'providers/products.dart';
import '../providers/orders.dart';
import '../screens/edit_product_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.white),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //We4 should use the standard way here.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          //
          create: (c) => Products(),
        ),
        ChangeNotifierProvider(
          //
          create: (c) => Cart(),
        ),
        ChangeNotifierProvider(
          //
          create: (c) => Orders(),
        ),
      ],

      //Provides an instance of this class to all childs interested.
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
          primaryColor: Colors.redAccent,
          primarySwatch: Colors.red,
          accentColor: Colors.black,
          scaffoldBackgroundColor: Colors.grey[100],
          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.red),
            titleTextStyle: TextStyle(
              color: Colors.purple,
              fontFamily: 'Anton',
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
            centerTitle: true,
            elevation: 0,
          ),
          // accentColor: Colors.red.shade700,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
