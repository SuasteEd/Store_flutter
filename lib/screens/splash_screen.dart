import 'package:examen_2p/controllers/data_controller.dart';
import 'package:examen_2p/screens/screens.dart';
import 'package:examen_2p/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = Get.put(DataController());
  @override
  void initState() {
    fillData();
    super.initState();
  }

  Future<void> fillData() async {
    await controller.getAllProducts();
    Future.delayed(const Duration(seconds: 2), () {
     Get.to(()=> const LoginScreen(), transition: Transition.circularReveal, duration: const Duration(seconds: 3));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/json/splash.json'),
      ),
    );
  }
}
