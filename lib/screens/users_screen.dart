import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UsersScreen extends StatelessWidget {
const UsersScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users Screen'),
      ),
      body: Center(
      child: Column(
        children: [
         CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white.withOpacity(0.3),
                  child: Hero(
                      tag: 'user',
                      child: Lottie.asset('assets/json/user.json'))),
        ],
      ),
    ),
    );
  }
}