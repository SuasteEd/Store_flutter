import 'package:flutter/material.dart';

class UsersList extends StatefulWidget {
  const UsersList({ Key? key }) : super(key: key);

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
      ),
      body: Center(
        child: Column(
        children: [
          Expanded(child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('User $index'),
                subtitle: Text('User $index'),
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {},
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