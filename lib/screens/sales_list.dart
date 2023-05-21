import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../controllers/data_controller.dart';
import '../services/firebase_services.dart';

class SalesList extends StatefulWidget {
  const SalesList({ Key? key }) : super(key: key);

  @override
  _SalesListState createState() => _SalesListState();
}

class _SalesListState extends State<SalesList> {
  final _controller = Get.put(DataController());
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales List'),
      ),
      body: StreamBuilder(
          stream: FireBaseResponse().getSales(),
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
                                final id = _controller.sales[index].id;
                                _listKey.currentState!.removeItem(
                                  index,
                                  (context, animation) => Container(),
                                );
                                await _controller.deleteSale(id!);
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                            )
                          ],
                        ),
                        child: Card(
                          child: ListTile(
                            title: Text('${data[index]['productName']}'),
                            subtitle: Text(_controller.users.firstWhere((e) => e.id == data[index]['vendorId']).name),
                            trailing: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.of(context).pushNamed('sales',
                                      arguments: _controller.sales.firstWhere(
                                          (element) =>
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
                                              'Sales Info',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                                'Product Name: ${data[index]['productName']}'),
                                             Text('Vendor name: ${_controller.users.firstWhere((e) => e.id == data[index]['vendorId']).name}'),
                                            // Text('Age: ${data[index]['age']}'),
                                            Text('Price: \$${data[index]['subtotal']}'),
                                            Text('Total:  \$${data[index]['total']}'),
                                            Text('Amount: ${data[index]['amount']}'),
                                            Text('Pieces: ${data[index]['pieces']}'),
                                            // Text('Role: ${data[index]['role']}'),
                                            // Text('Email: ${data[index]['email']}'),
                                            // Text('Password: ${data[index]['password']}'),
                                            // Text('Gender: ${data[index]['gender']}'),
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