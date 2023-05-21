import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../controllers/data_controller.dart';
import '../services/firebase_services.dart';

class PurchaseList extends StatefulWidget {
  const PurchaseList({Key? key}) : super(key: key);

  @override
  _PurchaseListState createState() => _PurchaseListState();
}

class _PurchaseListState extends State<PurchaseList> {
  final _controller = Get.put(DataController());
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase List'),
      ),
      body: StreamBuilder(
          stream: FireBaseResponse().getPurchases(),
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
                      final name = _controller.users.firstWhere(
                          (element) => element.id == data[index]['idA']);
                      return Slidable(
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) async {
                                final id = _controller.purchases[index].id;
                                _listKey.currentState!.removeItem(
                                  index,
                                  (context, animation) => Container(),
                                );
                                await _controller.deletePurchase(id!);
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                            )
                          ],
                        ),
                        child: Card(
                          child: ListTile(
                            title: Text('${name.name} ${name.lastName}'),
                            subtitle: Text(_controller.products
                                .firstWhere(
                                    (e) => e.id == data[index]['productId'])
                                .name),
                            trailing: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.of(context).pushNamed('purchase',
                                      arguments: _controller.purchases
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
                                              'Purchase Info',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text('IDA: ${data[index]['idA']}'),
                                            Text(
                                                'Vendor name: ${_controller.users.firstWhere((e) => e.id == data[index]['idA']).name}'),
                                            Text(
                                                'ProductID : ${data[index]['productId']}'),
                                            Text(
                                                'ProductName: ${data[index]['productName']}'),
                                            Text(
                                                'Pieces: ${data[index]['pieces']}'),
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
