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

  // @override
  // void onInit() {
  //   getAllProducts();
  //   getAllPurchases();
  //   getAllSales();
  //   getAllUsers();
  //   super.onInit();
  // }

  Future<void> getAllProducts() async {
    products.clear();
    products.value = await getProducts();
  }

  Future<void> getAllPurchases() async {
    purchases.value = await getPurchases();
  }

  Future<void> getAllSales() async {
    sales.value = await getSales();
  }

  Future<void> getAllUsers() async {
    users.value = await getUsers();
  }

  Future<void> addProduct(Product product) async {
    await addProduct(product);
    await getAllProducts();
  }

  Future<void> addUser(User user) async {
    await addUser(user);
    await getAllUsers();
  }

  Future<void> addPurchase(Purchase purchase) async {
    await addPurchase(purchase);
    await getAllPurchases();
  }

  Future<void> addSale(Sale sale) async {
    await addSale(sale);
    await getAllSales();
  }
}
