import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white.withOpacity(0.3),
                child: Hero(
                    tag: 'product',
                    child: Lottie.asset('assets/json/products.json'))),
          ],
        ),
      ),
    );
  }
}
