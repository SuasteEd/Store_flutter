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
  print(querySnapshot.docs.length);
  return usersModel;
}

Future<void> postProduct(Product product) async {
  await collectionRef.add({
    'name': product.name,
    'description': product.description,
    'cost': product.cost,
    'price': product.price,
    'units': product.units,
    'utility': product.utility,
  });
}

Future<void> postPurchase(Purchase purchase) async {
  await firestore.collection('Purchases').add({
    'idA': purchase.idA,
    'pieces': purchase.pieces,
    'productId': purchase.productId,
    'productName': purchase.productName,
  });
}

Future<void> postSale(Sale sale) async {
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

Future<void> postUser(User user) async {
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

Future<void> deleteProductById(String id) async {
  await firestore.collection('Products').doc(id).delete();
}

Future<void> deletePurchaseById(String id) async {
  await firestore.collection('Purchases').doc(id).delete();
}

Future<void> deleteSaleById(String id) async {
  await firestore.collection('Sales').doc(id).delete();
}

Future<void> deleteUserById(String id) async {
  await firestore.collection('Users').doc(id).delete();
}

Future<void> updateUserById(User user) async {
  await firestore.collection('User').doc(user.id).update({
    'name': user.name,
    'lastName': user.lastName,
    'age': user.age,
    'gender': user.gender,
    'email': user.email,
    'password': user.password,
    'role': user.role
  });
}

Future<void> updateSaleById(Sale sale) async {
  await firestore.collection('Sales').doc(sale.id).update({
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
  await firestore.collection('Products').doc(product.id).update({
    'name': product.name,
    'description': product.description,
    'cost': product.cost,
    'price': product.price,
    'units': product.units,
    'utility': product.utility,
  });
}
