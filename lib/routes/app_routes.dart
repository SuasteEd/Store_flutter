import 'package:flutter/material.dart';
import '../screens/screens.dart';

class AppRoutes {
  static const initialRoute = '/';

  static Map<String, Widget Function(BuildContext)> routes = {
    '/' : (_) => const SplashScreen(),
    'login': (_) => LoginScreen(),
    'home': (_) => HomeScreen(),
    'sales': (_) => SalesScreen(),
    'purchase': (_) => PurchaseScreen(),
    'products': (_) => ProductsScreen(),
    'users': (_) => UsersScreen(),
    'users_list': (_) => UsersList(),
    'products_list': (_) => ProductsList(),
    'sales_list': (_) => SalesList(),
    'purchase_list': (_) => PurchaseList(),
    'products_list': (_) => ProductsList(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => HomeScreen());
  }
}