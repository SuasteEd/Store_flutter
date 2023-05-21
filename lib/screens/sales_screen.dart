import 'package:examen_2p/alerts/alert_error.dart';
import 'package:examen_2p/controllers/data_controller.dart';
import 'package:examen_2p/models/products_model.dart';
import 'package:examen_2p/models/sales_model.dart';
import 'package:examen_2p/theme/app_theme.dart';
import 'package:examen_2p/widgets/custom_button.dart';
import 'package:examen_2p/widgets/custom_circle_avatar.dart';
import 'package:examen_2p/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../alerts/alert_successful.dart';
import '../models/users_model.dart';
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
  final _controller = Get.put(DataController());
  List<Product> products = [];
  List<User> vendor = [];
  List<User> customer = [];
  bool _isPressed = false;

  @override
  void initState() {
    fillData();
    super.initState();
  }

  Future<void> fillData() async {
    products.addAll(_controller.products);
    vendor.addAll(_controller.users.where((e) => e.role == 'Vendor'));
    customer.addAll(_controller.users.where((e) => e.role == 'Customer'));
  }

  @override
  Widget build(BuildContext context) {
    final Sale? args = ModalRoute.of(context)?.settings.arguments as Sale?;
    if (args != null) {
      _idProduct.text = args.productId;
      _name.text = args.productName;
      _amount.text = args.amount.toString();
      _idv.text = args.vendorId;
      _idc.text = args.costumerId;
      _pieces.text = args.pieces.toString();
      _subtotal.text = args.subtotal.toString();
      _total.text = args.total.toString();
    }
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
                    productId: args != null
                      ? _controller.products.firstWhere(
                          (element) => element.id == _idProduct.text)
                      : null,
                    vendorId: args != null
                        ? _controller.users
                            .firstWhere((element) => element.id == _idv.text)
                        : null,
                    customerId: args != null
                        ? _controller.users
                            .firstWhere((element) => element.id == _idc.text)
                        : null,
                    customer: customer,
                    vendor: vendor,
                    suggestionsId: _controller.products,
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
                      : Text(
                          args == null ? 'Save' : 'Update',
                          style: AppTheme.textButton,
                        ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _isPressed = true;
                      setState(() {});
                      final sale = Sale(
                          id: args?.id,
                          productId: _idProduct.text,
                          costumerId: _idc.text,
                          productName: _name.text,
                          vendorId: _idv.text,
                          amount: double.parse(_amount.text),
                          pieces: double.parse(_pieces.text),
                          subtotal: double.parse(_subtotal.text),
                          total: double.parse(_total.text));

                      final double pieces = _controller.products
                          .firstWhere(
                              (element) => element.id == _idProduct.text)
                          .units;

                     if(args == null){
                       if (pieces < int.parse(_pieces.text)) {
                        print(pieces);
                        _isPressed = false;
                        setState(() {});
                        alertError(context, 'Enough pieces');
                      } else {
                        if (await _controller.addSale(sale)) {
                          _isPressed = false;
                          setState(() {});
                          // ignore: use_build_context_synchronously
                          alertSucces(context, 'Sale saved successfully!');
                        }
                      }
                     } else {
                      if(await _controller.updateSale(sale)){
                        _isPressed = false;
                        setState(() {});
                        alertSucces(context, 'Sale updated successfully!');
                      } else {
                        _isPressed = false;
                        setState(() {});
                        alertError(context, 'Error updating sale');
                      }
                     }
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

class SalesForm extends StatefulWidget {
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
    required this.vendor,
    required this.customer,
    this.vendorId,
    this.customerId, this.productId,
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
  final List<User> vendor;
  final List<User> customer;
  final GlobalKey<FormState> _formKey;
  final TextEditingController _idProduct;
  final TextEditingController _name;
  final TextEditingController _amount;
  final TextEditingController _idv;
  final TextEditingController _idc;
  final TextEditingController _pieces;
  final TextEditingController _subtotal;
  final TextEditingController _total;
  final Product? productId;
  final User? vendorId;
  final User? customerId;

  @override
  State<SalesForm> createState() => _SalesFormState();
}

class _SalesFormState extends State<SalesForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
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
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(20),
            ),
            child: DropdownButtonFormField(
              value: widget.productId,
              hint: const Text('Product Name',
                  style: TextStyle(color: Colors.black)),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
              ),
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  widget._name.text = value!.name;
                  widget._idProduct.text = value.id.toString();
                });
              },
              items: widget.suggestionsId.map((Product value) {
                return DropdownMenuItem<Product>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(20),
            ),
            child: DropdownButtonFormField(
              value: widget.vendorId,
              hint: const Text('Vendor name',
                  style: TextStyle(color: Colors.black)),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
              ),
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  widget._idv.text = value!.name;
                  widget._idv.text = value.id.toString();
                });
              },
              items: widget.vendor.map((User value) {
                return DropdownMenuItem<User>(
                  value: value,
                  child: Text('${value.name} ${value.lastName}'),
                );
              }).toList(),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(20),
            ),
            child: DropdownButtonFormField(
              value: widget.customerId,
              hint: const Text('Customer name',
                  style: TextStyle(color: Colors.black)),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                icon: Icon(
                  Icons.person_outlined,
                  color: Colors.black,
                ),
              ),
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  widget._idc.text = value!.name;
                  widget._idc.text = value.id.toString();
                });
              },
              items: widget.customer.map((User value) {
                return DropdownMenuItem<User>(
                  value: value,
                  child: Text('${value.name} ${value.lastName}'),
                );
              }).toList(),
            ),
          ),
          CustomTextFormField(
            controller: widget._amount,
            labelText: "Amount",
            hintText: "Enter the amount",
            obscureText: false,
            icon: Icons.monetization_on_outlined,
            keyboardType: TextInputType.number,
            validationMessage: 'Please enter an amount',
          ),
          CustomTextFormField(
            controller: widget._pieces,
            labelText: "Pieces",
            hintText: "Enter the number of pieces",
            obscureText: false,
            icon: Icons.format_list_numbered,
            keyboardType: TextInputType.number,
            validationMessage: 'Please enter the number of pieces',
          ),
          CustomTextFormField(
            // enabled: false,
            controller: widget._subtotal,
            labelText: "Subtotal",
            hintText: "Enter the subtotal",
            obscureText: false,
            icon: Icons.attach_money_outlined,
            keyboardType: TextInputType.number,
            validationMessage: 'Please enter a subtotal',
          ),
          CustomTextFormField(
            // enabled: false,
            controller: widget._total,
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
