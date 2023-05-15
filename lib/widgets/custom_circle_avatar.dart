import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String tag;
  final String json;
  const CustomCircleAvatar({
    super.key, required this.tag, required this.json,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(70),
      ),
      child: CircleAvatar(
        radius: 70,
        backgroundColor: Colors.white.withOpacity(0.3),
        child: Hero(
          tag: tag,
          child: Lottie.asset(json),
        ),
      ),
    );
  }
}