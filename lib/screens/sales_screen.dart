import 'package:examen_2p/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Title'),
        ),
        body: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white.withOpacity(0.3),
                  child: Hero(
                      tag: 'Sales',
                      child: Lottie.asset('assets/json/sale.json'))),
            ],
          ),
        ));
  }
}
