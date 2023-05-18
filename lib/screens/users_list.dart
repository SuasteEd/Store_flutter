import 'package:examen_2p/controllers/data_controller.dart';
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
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: AnimatedList(
                initialItemCount: _controller.users.length,
                key: _listKey,
                itemBuilder: (context, index, animation) {
                  return Slidable(
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            _listKey.currentState!.removeItem(
                            index,
                            (context, animation) => Container(),
                          );
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                        )
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                       
                        color: Colors.white
                      
                      ),
                      child: ListTile(
                        title: Text(_controller.users[index].name),
                        subtitle: Text(_controller.users[index].email),
                        trailing: IconButton(
                          onPressed: () {
                            //_controller.deleteUser(_controller.users[index].id);
                            
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        onTap: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('User Info'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                          'Name: ${_controller.users[index].name}'),
                                      Text(
                                          'Email: ${_controller.users[index].email}'),
                                      Text(
                                          'Password: ${_controller.users[index].password}'),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Close'))
                                  ],
                                )),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
