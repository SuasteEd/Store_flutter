import 'package:examen_2p/widgets/custom_button.dart';
import 'package:examen_2p/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../alerts/alert_successful.dart';
import '../widgets/custom_circle_avatar.dart';
import '../widgets/custom_text_form_field.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final _id = TextEditingController();
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _units = TextEditingController();
  final _cost = TextEditingController();
  final _price = TextEditingController();
  final _utility = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register a product'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const CustomCircleAvatar(
                  tag: 'product', json: 'assets/json/products.json'),
              const SizedBox(height: 20),
              ProductForm(
                  formKey: _formKey,
                  id: _id,
                  name: _name,
                  description: _description,
                  units: _units,
                  cost: _cost,
                  price: _price,
                  utility: _utility),
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
                      alertSucces(context, 'User saved successfully!');
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class ProductForm extends StatelessWidget {
  const ProductForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController id,
    required TextEditingController name,
    required TextEditingController description,
    required TextEditingController units,
    required TextEditingController cost,
    required TextEditingController price,
    required TextEditingController utility,
  })  : _formKey = formKey,
        _id = id,
        _name = name,
        _description = description,
        _units = units,
        _cost = cost,
        _price = price,
        _utility = utility;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _id;
  final TextEditingController _name;
  final TextEditingController _description;
  final TextEditingController _units;
  final TextEditingController _cost;
  final TextEditingController _price;
  final TextEditingController _utility;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormField(
            controller: _id,
            labelText: "ID",
            hintText: 'Enter your ID',
            icon: Icons.vpn_key,
            keyboardType: TextInputType.number,
            validationMessage: 'Please enter an ID',
            obscureText: false,
          ),
          CustomTextFormField(
            controller: _name,
            labelText: "Name",
            hintText: 'Enter your name',
            icon: Icons.person,
            keyboardType: TextInputType.name,
            obscureText: false,
            validationMessage: 'Please enter a name',
          ),
          CustomTextFormField(
            controller: _description,
            labelText: "Description",
            hintText: 'Enter your description',
            keyboardType: TextInputType.text,
            obscureText: false,
            icon: Icons.description,
            validationMessage: 'Please enter a description',
          ),
          CustomTextFormField(
            controller: _units,
            hintText: 'Enter your units',
            labelText: "Units",
            icon: Icons.add_shopping_cart,
            keyboardType: TextInputType.number,
            obscureText: false,
            validationMessage: 'Please enter the number of units',
          ),
          CustomTextFormField(
            controller: _cost,
            labelText: "Cost",
            hintText: 'Enter your cost',
            icon: Icons.monetization_on,
            obscureText: false,
            keyboardType: TextInputType.number,
            validationMessage: 'Please enter a cost',
          ),
          CustomTextFormField(
            controller: _price,
            labelText: "Price",
            hintText: 'Enter your price',
            icon: Icons.attach_money,
            obscureText: false,
            keyboardType: TextInputType.number,
            validationMessage: 'Please enter a price',
          ),
          CustomTextFormField(
            controller: _utility,
            labelText: "Utility",
            hintText: 'Enter your utility',
            icon: Icons.poll,
            keyboardType: TextInputType.number,
            obscureText: false,
            validationMessage: 'Please enter a utility',
          ),
        ],
      ),
    );
  }
}
