import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PurchaseScreen extends StatelessWidget {
const PurchaseScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase Screen'),
      ),
      body: Center(
      child: Column(
        children: [
         CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white.withOpacity(0.3),
                  child: Hero(
                      tag: 'Purchase',
                      child: Lottie.asset('assets/json/purchase.json'))),
        ],
      ),
    ),
    );
  }
}