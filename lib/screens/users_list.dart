import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examen_2p/alerts/alert_error.dart';
import 'package:examen_2p/alerts/alert_successful.dart';
import 'package:examen_2p/controllers/data_controller.dart';
import 'package:examen_2p/services/firebase_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final _controller = Get.put(DataController());
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  int initialItemCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
      ),
      body: StreamBuilder(
          stream: FireBaseResponse().getUsers(),
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
                                final id = _controller.users[index].id;
                                _listKey.currentState!.removeItem(
                                  index,
                                  (context, animation) => Container(),
                                );
                                await _controller.deleteUser(id!);
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                            )
                          ],
                        ),
                        child: Card(
                          child: ListTile(
                            title: Text(
                                '${data[index]['name']} ${data[index]['lastName']}'),
                            subtitle: Text('${data[index]['role']}'),
                            trailing: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.of(context).pushNamed('users',
                                      arguments: _controller.users.firstWhere(
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
                                              'User Info',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                                'Name: ${data[index]['name']} ${data[index]['lastName']}'),
                                            Text('Age: ${data[index]['age']}'),
                                            Text('Role: ${data[index]['role']}'),
                                            Text('Email: ${data[index]['email']}'),
                                            Text('Password: ${data[index]['password']}'),
                                            Text('Gender: ${data[index]['gender']}'),
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
