import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examen_2p/models/products_model.dart';
import 'package:examen_2p/models/purchases_model.dart';
import 'package:examen_2p/models/sales_model.dart';
import 'package:examen_2p/models/users_model.dart';

class FireBaseResponse {
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('Products');
  final CollectionReference _sales =
      FirebaseFirestore.instance.collection('Sales');
  final CollectionReference _purchases =
      FirebaseFirestore.instance.collection('Purchases');
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('Users');

  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  // final CollectionReference collectionRef = firestore.collection('Products');



  Stream<QuerySnapshot<Object?>> getProducts() {
    return _products.snapshots();
  }

  Stream<QuerySnapshot<Object?>> getSales() {
    return _sales.snapshots();
  }

  Stream<QuerySnapshot<Object?>> getPurchases() {
    return _purchases.snapshots();
  }

  Stream<QuerySnapshot<Object?>> getUsers() {
    return _users.snapshots();
  }

  Future<List<Product>> getAllProducts() async {
  List<Product> productsModel = [];
  QuerySnapshot querySnapshot = await _products.get();
  for (var element in querySnapshot.docs) {
    productsModel.add(
      Product(
        id: element.id,
        name: element['name'],
        description: element['description'],
        cost: element['cost'],
        price: element['price'],
        units: element['units'],
        utility: element['utility'],
      ),
    );
  }
  return productsModel;
}

  Future<List<Purchase>> getAllPurchases() async {
    List<Purchase> purchaseModel = [];
    QuerySnapshot querySnapshot = await _purchases.get();
    for (var element in querySnapshot.docs) {
      purchaseModel.add(
        Purchase(
          id: element.id,
          idA: element['idA'],
          pieces: element['pieces'],
          productId: element['productId'],
          productName: element['productName'],
        ),
      );
    }
    return purchaseModel;
  }

  Future<List<Sale>> getAllSales() async {
    List<Sale> salesModel = [];
    QuerySnapshot querySnapshot = await _sales.get();
    for (var element in querySnapshot.docs) {
      salesModel.add(
        Sale(
          id: element.id,
          productId: element['productId'],
          costumerId: element['customerId'],
          productName: element['productName'],
          vendorId: element['vendorId'],
          amount: element['amount'],
          pieces: element['pieces'],
          subtotal: element['subtotal'],
          total: element['total'],
        ),
      );
    }
    return salesModel;
  }

  Future<List<User>> getAllUsers() async {
    List<User> usersModel = [];
    QuerySnapshot querySnapshot = await _users.get();
    for (var element in querySnapshot.docs) {
      usersModel.add(
        User(
          id: element.id,
          name: element['name'],
          lastName: element['lastName'],
          age: element['age'],
          gender: element['gender'],
          email: element['email'],
          password: element['password'],
          role: element['role'],
        ),
      );
    }
    print(querySnapshot.docs.length);
    return usersModel;
  }

  Future<void> postProduct(Product product) async {
    await _products.add({
      'name': product.name,
      'description': product.description,
      'cost': product.cost,
      'price': product.price,
      'units': product.units,
      'utility': product.utility,
    });
  }

  Future<void> postPurchase(Purchase purchase) async {
    await _purchases.add({
      'idA': purchase.idA,
      'pieces': purchase.pieces,
      'productId': purchase.productId,
      'productName': purchase.productName,
    });
  }

  Future<void> postSale(Sale sale) async {
    try {
      await _sales.add({
        'productId': sale.productId,
        'customerId': sale.costumerId,
        'productName': sale.productName,
        'vendorId': sale.vendorId,
        'amount': sale.amount,
        'pieces': sale.pieces,
        'subtotal': sale.subtotal,
        'total': sale.total,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> postUser(User user) async {
    await _users.add({
      'name': user.name,
      'lastName': user.lastName,
      'email': user.email,
      'password': user.password,
      'gender': user.gender,
      'age': user.age,
      'role': user.role,
    });
  }

  Future<void> deleteProductById(String id) async {
    await _products.doc(id).delete();
  }

  Future<void> deletePurchaseById(String id) async {
    await _purchases.doc(id).delete();
  }

  Future<void> deleteSaleById(String id) async {
    await _sales.doc(id).delete();
  }

   Future<void> deleteUserById(String id) async {
    await _users.doc(id).delete();
   }

  Future<void> updateUserById(User user) async {
    await _users.doc(user.id).update({
      'name': user.name,
      'lastName': user.lastName,
      'age': user.age,
      'gender': user.gender,
      'email': user.email,
      'password': user.password,
      'role': user.role
    });
  }

   Future<void> updateQuantityProduct(Product product) async {
    print(product.id);
    await _products.doc(product.id).update({
      'units': product.units,
    }).then((value) => print('Actualizado'), onError: (error) => print('Error de actualizacion $error ${product.id}'));
  }

  Future<void> updateSaleById(Sale sale) async {
    await _sales.doc(sale.id).update({
      'productId': sale.productId, // 'productId' : 'id del producto'
      'productName': sale.productName,
      'amount': sale.amount,
      'vendorId': sale.vendorId,
      'customerId': sale.costumerId,
      'pieces': sale.pieces,
      'subtotal': sale.subtotal,
      'total': sale.total
    });
  }

  Future<void> updateProductById(Product product) async {
    await _products.doc(product.id).update({
      'name': product.name,
      'description': product.description,
      'cost': product.cost,
      'price': product.price,
      'units': product.units,
      'utility': product.utility,
    });
  }

  Future<void> updatePurchaseById(Purchase purchase) async {
    await _purchases.doc(purchase.id).update({
      'idA': purchase.idA,
      'pieces': purchase.pieces,
      'productId': purchase.productId,
      'productName': purchase.productName,
    });
  }
}
