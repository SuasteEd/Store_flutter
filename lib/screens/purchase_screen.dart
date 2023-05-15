import 'package:examen_2p/widgets/custom_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../alerts/alert_successful.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/loading_button.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({Key? key}) : super(key: key);

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idProduct = TextEditingController();
  final _name = TextEditingController();
  final _pieces = TextEditingController();
  final _ida = TextEditingController();
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            const CustomCircleAvatar(
                tag: 'Purchase', json: 'assets/json/purchase.json'),
            const SizedBox(height: 20),
            PurchaseForm(
                formKey: _formKey,
                idProduct: _idProduct,
                name: _name,
                pieces: _pieces,
                ida: _ida),
            CustomButton(
                text: _isPressed
                    ? const LoadingButton()
                    : const Text(
                        'Save',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'Poppins'),
                      ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _isPressed = true;
                    setState(() {});
                    Future.delayed(const Duration(seconds: 1), () {
                      _isPressed = false;
                      setState(() {});
                    });
                    alertSucces(context, 'Purchase saved successfully!');
                  }
                })
          ],
        ),
      ),
    );
  }
}

class PurchaseForm extends StatelessWidget {
  const PurchaseForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController idProduct,
    required TextEditingController name,
    required TextEditingController pieces,
    required TextEditingController ida,
  })  : _formKey = formKey,
        _idProduct = idProduct,
        _name = name,
        _pieces = pieces,
        _ida = ida;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _idProduct;
  final TextEditingController _name;
  final TextEditingController _pieces;
  final TextEditingController _ida;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormField(
            controller: _idProduct,
            labelText: "Product ID",
            hintText: 'Enter the product ID',
            obscureText: false,
            icon: Icons.vpn_key,
            keyboardType: TextInputType.number,
            validationMessage: 'Please enter a product ID',
          ),
          CustomTextFormField(
            controller: _name,
            labelText: "Product Name",
            hintText: 'Enter the product name',
            obscureText: false,
            keyboardType: TextInputType.name,
            icon: Icons.shopping_cart,
            validationMessage: 'Please enter a product name',
          ),
          CustomTextFormField(
            controller: _pieces,
            labelText: "Pieces",
            hintText: 'Enter the number of pieces',
            obscureText: false,
            icon: Icons.format_list_numbered,
            keyboardType: TextInputType.number,
            validationMessage: 'Please enter the number of pieces',
          ),
          CustomTextFormField(
            controller: _ida,
            hintText: 'Enter the IDA',
            labelText: "IDA",
            obscureText: false,
            keyboardType: TextInputType.number,
            icon: Icons.person,
            validationMessage: 'Please enter an IDA',
          ),
        ],
      ),
    );
  }
}
