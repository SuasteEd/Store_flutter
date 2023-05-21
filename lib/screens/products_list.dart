import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examen_2p/alerts/alert_error.dart';
import 'package:examen_2p/models/users_model.dart';
import 'package:examen_2p/theme/app_theme.dart';
import 'package:examen_2p/widgets/custom_button.dart';
import 'package:examen_2p/widgets/custom_circle_avatar.dart';
import 'package:examen_2p/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../alerts/alert_successful.dart';
import '../controllers/data_controller.dart';
import '../services/firebase_services.dart';
import '../widgets/custom_text_form_field.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({Key? key}) : super(key: key);

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  final _controller = Get.put(DataController());
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products List'),
      ),
      body: StreamBuilder(
          stream: FireBaseResponse().getProducts(),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }
            return Center(
              child: Column(
                children: [
                  Expanded(
                      child: AnimatedList(
                    key: _listKey,
                    initialItemCount: data!.length,
                    itemBuilder: (context, index, animation) {
                      return Slidable(
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) async {
                                final id = _controller.products[index].id;
                                _listKey.currentState!.removeItem(
                                  index,
                                  (context, animation) => Container(),
                                );
                                await _controller.deleteProduct(id!);
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                            )
                          ],
                        ),
                        child: Card(
                          child: ListTile(
                            title: Text('${data[index]['name']}'),
                            subtitle: Text('${data[index]['description']}'),
                            trailing: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.of(context).pushNamed('products',
                                      arguments: _controller.products
                                          .firstWhere((element) =>
                                              element.id == data[index].id));
                                }),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                          child: Container(
                                        height: 200,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Products Info',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                                'Product Name: ${data[index]['name']}'),
                                            Text(
                                                'Description: ${data[index]['description']}'),
                                            Text(
                                                'Cost: \$${data[index]['cost']}'),
                                            Text(
                                                'Price:  \$${data[index]['price']}'),
                                            Text(
                                                'Amount: ${data[index]['units']}'),
                                            Text(
                                                'Utility: ${data[index]['utility']}'),
                                          ],
                                        ),
                                      )));
                            },
                          ),
                        ),
                      );
                    },
                  )),
                ],
              ),
            );
          }),
    );
  }
}
