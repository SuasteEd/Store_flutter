import 'dart:ffi';

import 'package:examen_2p/models/products_model.dart';
import 'package:examen_2p/models/purchases_model.dart';
import 'package:examen_2p/models/sales_model.dart';
import 'package:examen_2p/models/users_model.dart';
import 'package:get/get.dart';
import '../services/firebase_services.dart';

class DataController extends GetxController {
  final products = <Product>[].obs;
  final purchases = <Purchase>[].obs;
  final sales = <Sale>[].obs;
  final users = <User>[].obs;
  // Future<void> getAllPurchases() async {
  //   purchases.value = await getPurchases();
  // }

  Future<void> getAllProducts() async {
    products.clear();
    products.value = await FireBaseResponse().getAllProducts();
  }

  Future<void> getAllUsers() async {
    users.clear();
    users.value = await FireBaseResponse().getAllUsers();
  }

  Future<void> getAllSales() async {
    sales.clear();
    sales.value = await FireBaseResponse().getAllSales();
  }
  
  Future<void> getAllPurchases() async {
    purchases.clear();
    purchases.value = await FireBaseResponse().getAllPurchases();
  }





  Future<bool> addProduct(Product product) async {
    try {
      FireBaseResponse().postProduct(product);
      await getAllProducts();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addUser(User user) async {
    try {
      await FireBaseResponse().postUser(user);
      await getAllUsers();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addPurchase(Purchase purchase) async {
    try {
      FireBaseResponse().postPurchase(purchase);
      await getAllPurchases();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addSale(Sale sale) async {
    try {
      FireBaseResponse().postSale(sale);
      await getAllSales();
      return true;
    } catch (e) {
      return false;
    }
  }




  // Future<void> deleteProduct(String id) async {
  //   await deleteProductById(id);
  //   await getAllProducts();
  // }

  Future<void> updateQuantityProduct(Product product) async {
    await FireBaseResponse().updateQuantityProduct(product);
    await getAllProducts();
  }

  Future<bool> updateUser(User user) async {
    try {
      await FireBaseResponse().updateUserById(user);
      await getAllUsers();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateProduct(Product product) async {
    try {
      await FireBaseResponse().updateProductById(product);
      await getAllProducts();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updatePurchase(Purchase purchase) async {
    try {
      await FireBaseResponse().updatePurchaseById(purchase);
      await getAllPurchases();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

    Future<bool> updateSale(Sale sale) async {
    try {
      await FireBaseResponse().updateSaleById(sale);
      await getAllPurchases();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }


  Future<bool> deleteProduct(String id) async {
    try {
      await FireBaseResponse().deleteProductById(id); 
      await getAllProducts();
      return true;
    } catch (e) {
      print(e); 
      return false;
    }
  }

  Future<bool> deleteUser(String id) async {
    try {
      await FireBaseResponse().deleteUserById(id); 
      await getAllUsers();
      return true;
    } catch (e) {
      print(e); 
      return false;
    }
  }

  Future<bool> deleteSale(String id) async {
    try {
      await FireBaseResponse().deleteSaleById(id); 
      await getAllUsers();
      return true;
    } catch (e) {
      print(e); 
      return false;
    }
  }

  Future<bool> deletePurchase(String id) async {
    try {
      await FireBaseResponse().deletePurchaseById(id); 
      await getAllUsers();
      return true;
    } catch (e) {
      print(e); 
      return false;
    }
  }
}
