import 'package:examen_2p/alerts/alert_error.dart';
import 'package:examen_2p/widgets/custom_button.dart';
import 'package:examen_2p/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../alerts/alert_successful.dart';
import '../controllers/data_controller.dart';
import '../models/products_model.dart';
import '../theme/app_theme.dart';
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
  final _controller = Get.put(DataController());
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final Product? args =
        ModalRoute.of(context)?.settings.arguments as Product?;
    if (args != null) {
      _name.text = args.name;
      _description.text = args.description;
      _units.text = args.units.toString();
      _cost.text = args.cost.toString();
      _price.text = args.price.toString();
      _utility.text = args.utility.toString();
    }
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
                  name: _name,
                  description: _description,
                  units: _units,
                  cost: _cost,
                  price: _price,
                  utility: _utility),
              CustomButton(
                  text: _isPressed
                      ? const LoadingButton()
                      : Text(
                          args == null ? 'Save' : 'Update',
                          style: AppTheme.textButton,
                        ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _isPressed = true;
                      setState(() {});
                      final product = Product(
                          id: args?.id,
                          name: _name.text,
                          description: _description.text,
                          units: double.parse(_units.text),
                          cost: double.parse(_cost.text),
                          price: double.parse(_price.text),
                          utility: double.parse(_utility.text));
                      if (args == null) {
                        if (await _controller.addProduct(product)) {
                          alertSucces(context, 'Product saved successfully!');
                          _isPressed = false;
                          // ignore: use_build_context_synchronously
                          setState(() {});
                        } else {
                          _isPressed = false;
                          setState(() {});
                          // ignore: use_build_context_synchronously
                          alertError(context, 'Error saving product!');
                        }
                      } else {
                        if (await _controller.updateProduct(product)) {
                          _isPressed = false;
                          setState(() {});
                          // ignore: use_build_context_synchronously
                          alertSucces(context, 'Product updated successfully!');
                        } else {
                          _isPressed = false;
                          setState(() {});
                          // ignore: use_build_context_synchronously
                          alertError(context, 'Error updating product!');
                        }
                      }
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
    required TextEditingController name,
    required TextEditingController description,
    required TextEditingController units,
    required TextEditingController cost,
    required TextEditingController price,
    required TextEditingController utility,
  })  : _formKey = formKey,
        _name = name,
        _description = description,
        _units = units,
        _cost = cost,
        _price = price,
        _utility = utility;

  final GlobalKey<FormState> _formKey;
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
