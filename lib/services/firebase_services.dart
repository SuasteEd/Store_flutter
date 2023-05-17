import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examen_2p/models/products_model.dart';
import 'package:examen_2p/models/purchases_model.dart';
import 'package:examen_2p/models/sales_model.dart';
import 'package:examen_2p/models/users_model.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference collectionRef = firestore.collection('Products');

Future<List<Product>> getProducts() async {
  List<Product> productsModel = [];
  QuerySnapshot querySnapshot = await firestore.collection('Products').get();
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

Future<List<Purchase>> getPurchases() async {
  List<Purchase> purchaseModel = [];
  QuerySnapshot querySnapshot = await firestore.collection('Purchases').get();
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

Future<List<Sale>> getSales() async {
  List<Sale> salesModel = [];
  QuerySnapshot querySnapshot = await firestore.collection('Sales').get();
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

Future<List<User>> getUsers() async {
  List<User> usersModel = [];
  QuerySnapshot querySnapshot = await firestore.collection('Users').get();
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
  return usersModel;
}

Future<void> addProduct(Product product) async {
  await collectionRef.add({
    'name': product.name,
    'description': product.description,
    'cost': product.cost,
    'price': product.price,
    'units': product.units,
    'utility': product.utility,
  });
}

Future<void> addPurchase(Purchase purchase) async {
  await firestore.collection('Purchases').add({
    'idA': purchase.idA,
    'pieces': purchase.pieces,
    'productId': purchase.productId,
    'productName': purchase.productName,
  });
}

Future<void> addSale(Sale sale) async {
  await firestore.collection('Sales').add({
    'productId': sale.productId,
    'customerId': sale.costumerId,
    'productName': sale.productName,
    'vendorId': sale.vendorId,
    'amount': sale.amount,
    'pieces': sale.pieces,
    'subtotal': sale.subtotal,
    'total': sale.total,
  });
}

Future<void> addUser(User user) async {
  await firestore.collection('Users').add({
    'name': user.name,
    'lastName': user.lastName,
    'email': user.email,
    'password': user.password,
    'gender': user.gender,
    'age': user.age,
    'role': user.role,
  });
}
