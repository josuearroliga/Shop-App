import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:provider/provider.dart';

import './screens/product_details_screen.dart';
import './screens/products_overview_screen.dart';
import './widgets/product_item.dart';
import 'providers/products.dart';

void main() => runApp(MyApp());

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
      ],

      //Provides an instance of this class to all childs interested.
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primaryColor: Colors.purple,
          primarySwatch: Colors.purple,
          accentColor: Colors.blueAccent,
          scaffoldBackgroundColor: Colors.grey[100],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.red),
            titleTextStyle: TextStyle(
              color: Colors.purple,
              fontFamily: 'Lato',
              fontSize: 20,
              fontWeight: FontWeight.w600,
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
        },
      ),
    );
  }
}
