import 'package:examen_2p/controllers/data_controller.dart';
import 'package:examen_2p/models/products_model.dart';
import 'package:examen_2p/models/sales_model.dart';
import 'package:examen_2p/theme/app_theme.dart';
import 'package:examen_2p/widgets/custom_button.dart';
import 'package:examen_2p/widgets/custom_circle_avatar.dart';
import 'package:examen_2p/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';

import '../alerts/alert_successful.dart';
import '../widgets/custom_text_form_field.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idProduct = TextEditingController();
  final _name = TextEditingController();
  final _amount = TextEditingController();
  final _idv = TextEditingController();
  final _idc = TextEditingController();
  final _pieces = TextEditingController();
  final _subtotal = TextEditingController();
  final _total = TextEditingController();
  final _dataController = Get.put(DataController());
  List<Product> listSuggestions = [];
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register a Sale'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const CustomCircleAvatar(
                    tag: 'Sales', json: 'assets/json/sale.json'),
                const SizedBox(height: 20),
                SalesForm(
                    suggestionsId: _dataController.products,
                    formKey: _formKey,
                    idProduct: _idProduct,
                    name: _name,
                    amount: _amount,
                    idv: _idv,
                    idc: _idc,
                    pieces: _pieces,
                    subtotal: _subtotal,
                    total: _total),
                CustomButton(
                    text: _isPressed
                        ? const LoadingButton()
                        : const Text(
                            'Save',
                            style: AppTheme.textButton,
                          ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _isPressed = true;
                        setState(() {});
                        final sale = Sale(
                            productId: _idProduct.text,
                            costumerId: _idc.text,
                            productName: _name.text,
                            vendorId: _idv.text,
                            amount: double.parse(_amount.text),
                            pieces: double.parse(_pieces.text),
                            subtotal: double.parse(_subtotal.text),
                            total: double.parse(_total.text));
                        await _dataController.addSale(sale);
                        // ignore: use_build_context_synchronously
                        alertSucces(context, 'Sale saved successfully!');
                      }
                    }),
              ],
            ),
          ),
        ));
  }
}

class SalesForm extends StatelessWidget {
  const SalesForm({
    super.key,
    required this.suggestionsId,
    required GlobalKey<FormState> formKey,
    required TextEditingController idProduct,
    required TextEditingController name,
    required TextEditingController amount,
    required TextEditingController idv,
    required TextEditingController idc,
    required TextEditingController pieces,
    required TextEditingController subtotal,
    required TextEditingController total,
  })  : _formKey = formKey,
        _idProduct = idProduct,
        _name = name,
        _amount = amount,
        _idv = idv,
        _idc = idc,
        _pieces = pieces,
        _subtotal = subtotal,
        _total = total;
  final List<Product> suggestionsId;
  final GlobalKey<FormState> _formKey;
  final TextEditingController _idProduct;
  final TextEditingController _name;
  final TextEditingController _amount;
  final TextEditingController _idv;
  final TextEditingController _idc;
  final TextEditingController _pieces;
  final TextEditingController _subtotal;
  final TextEditingController _total;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CustomTextFormField(
          //   controller: _idProduct,
          //   labelText: "Product ID",
          //   hintText: "Enter the product ID",
          //   obscureText: false,
          //   icon: Icons.vpn_key,
          //   keyboardType: TextInputType.number,
          //   validationMessage: 'Please enter a product ID',
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SearchField<Product>(
              searchInputDecoration: InputDecoration(
                labelText: 'Product ID',
                hintText: 'Enter the product ID',
                fillColor: Colors.white,
                filled: true,
                prefixIcon: const Icon(
                  Icons.key,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
              controller: _idProduct,
              suggestions: suggestionsId
                  .map(
                    (e) => SearchFieldListItem<Product>(e.id,
                        item: e, child: Center(child: Text(e.id))),
                  )
                  .toList(),
              onSuggestionTap: (e) {
                _name.text = e.item!.name;
              },
            ),
          ),
          CustomTextFormField(
            controller: _name,
            labelText: "Product Name",
            hintText: "Enter the product name",
            obscureText: false,
            keyboardType: TextInputType.name,
            icon: Icons.shopping_cart,
            validationMessage: 'Please enter a product name',
          ),
          CustomTextFormField(
            controller: _amount,
            labelText: "Amount",
            hintText: "Enter the amount",
            obscureText: false,
            icon: Icons.monetization_on_outlined,
            keyboardType: TextInputType.number,
            validationMessage: 'Please enter an amount',
          ),
          CustomTextFormField(
            controller: _idv,
            labelText: "Vendor ID",
            hintText: "Enter the vendor ID",
            obscureText: false,
            icon: Icons.person,
            keyboardType: TextInputType.text,
            validationMessage: 'Please enter a vendor ID',
          ),
          CustomTextFormField(
            controller: _idc,
            labelText: "Customer ID",
            hintText: "Enter the customer ID",
            obscureText: false,
            icon: Icons.person_outline,
            keyboardType: TextInputType.text,
            validationMessage: 'Please enter a customer ID',
          ),
          CustomTextFormField(
            controller: _pieces,
            labelText: "Pieces",
            hintText: "Enter the number of pieces",
            obscureText: false,
            icon: Icons.format_list_numbered,
            keyboardType: TextInputType.number,
            validationMessage: 'Please enter the number of pieces',
          ),
          CustomTextFormField(
            controller: _subtotal,
            labelText: "Subtotal",
            hintText: "Enter the subtotal",
            obscureText: false,
            icon: Icons.attach_money_outlined,
            keyboardType: TextInputType.number,
            validationMessage: 'Please enter a subtotal',
          ),
          CustomTextFormField(
            controller: _total,
            labelText: "Total",
            hintText: "Enter the total",
            obscureText: false,
            icon: Icons.money_outlined,
            keyboardType: TextInputType.number,
            validationMessage: 'Please enter a total',
          ),
        ],
      ),
    );
  }
}
