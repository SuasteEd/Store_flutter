import 'package:examen_2p/theme/app_theme.dart';
import 'package:examen_2p/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 350,
              child: Lottie.asset('assets/json/login.json'),
            ),
            const Text('Welcome!',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.white)),
            LoginForm(
                formKey: _formKey,
                usernameController: usernameController,
                passwordController: passwordController),
            CustomButton(
              text: 'Sign in',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.usernameController,
    required this.passwordController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomTextFormField(
                labelText: 'User',
                hintText: 'Username',
                prefixIcon: const Icon(Icons.person),
                controller: usernameController,
                obscureText: false),
            CustomTextFormField(
                labelText: 'Password',
                hintText: 'Password',
                prefixIcon: const Icon(Icons.password),
                controller: passwordController,
                obscureText: true),
          ],
        ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.text,
  });
  final String text;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppTheme.secondary,
          border: Border.all(color: Colors.black),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.2),
          //     spreadRadius: 2,
          //     blurRadius: 5,
          //     offset: const Offset(0, 3),
          //   ),
          // ],
        ),
        child: MaterialButton(
          onPressed: onPressed,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Poppins'),
          ),
        ),
      ),
    );
  }
}
