import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 5));
  }
}