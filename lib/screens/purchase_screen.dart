import 'package:examen_2p/models/products_model.dart';
import 'package:examen_2p/widgets/custom_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../alerts/alert_successful.dart';
import '../controllers/data_controller.dart';
import '../models/purchases_model.dart';
import '../models/users_model.dart';
import '../theme/app_theme.dart';
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
  final _controller = Get.put(DataController());
  List<Product> products = [];
  List<User> users = [];
  bool _isPressed = false;

  @override
  void initState() {
    initData();
    super.initState();
  }

  Future<void> initData() async {
    products.addAll(_controller.products);
    users.addAll(_controller.users);
  }

  @override
  Widget build(BuildContext context) {
    final Purchase? args =
        ModalRoute.of(context)?.settings.arguments as Purchase?;
    if (args != null) {
      _idProduct.text = args.productId;
      _name.text = args.productName;
      _pieces.text = args.pieces.toString();
      _ida.text = args.idA;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase Screen'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const CustomCircleAvatar(
                  tag: 'Purchase', json: 'assets/json/purchase.json'),
              const SizedBox(height: 20),
              PurchaseForm(
                  product: args != null
                      ? _controller.products.firstWhere(
                          (element) => element.id == _idProduct.text)
                      : null,
                  user: args != null
                      ? _controller.users
                          .firstWhere((element) => element.id == _ida.text)
                      : null,
                  nameListUser: users,
                  formKey: _formKey,
                  idProduct: _idProduct,
                  nameList: products,
                  name: _name,
                  pieces: _pieces,
                  ida: _ida),
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
                      final product = _controller.products.firstWhere(
                          (element) => element.id == _idProduct.text);
                      final purchase = Purchase(
                          id: args?.id,
                          idA: _ida.text,
                          pieces: double.parse(_pieces.text),
                          productId: _idProduct.text,
                          productName: _name.text);
                      if (args == null) {
                        if (await _controller.addPurchase(purchase)) {
                          await _controller.updateQuantityProduct(Product(
                              id: _idProduct.text,
                              name: product.name,
                              description: product.description,
                              cost: product.cost,
                              price: product.price,
                              units: product.units + double.parse(_pieces.text),
                              utility: product.utility));
                          // ignore: use_build_context_synchronously
                          alertSucces(context, 'Purchase added successfully');
                          _isPressed = false;
                          setState(() {});
                        }
                      } else {
                        if (await _controller.updatePurchase(purchase)) {
                          await _controller.updateQuantityProduct(Product(
                              id: _idProduct.text,
                              name: product.name,
                              description: product.description,
                              cost: product.cost,
                              price: product.price,
                              units: product.units + double.parse(_pieces.text),
                              utility: product.utility));
                          // ignore: use_build_context_synchronously
                          alertSucces(context, 'Purchase updated successfully');
                          _isPressed = false;
                          setState(() {});
                        }
                      }
                      // if (pieces < int.parse(_pieces.text)) {
                      //   _isPressed = false;
                      //   setState(() {});
                      //   alertError(context, 'Enough pieces');
                      // } else {
                      //   final purchase = Purchase(idA: _ida.text, pieces: double.parse(_pieces.text), productId: _idProduct.text, productName: _name.text);
                      //   if(await _controller.addPurchase(purchase)){
                      //     _isPressed = false;
                      //     setState(() {});
                      //     // ignore: use_build_context_synchronously
                      //     alertSucces(context, 'Purchase added successfully');
                      //   }
                      // }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class PurchaseForm extends StatefulWidget {
  const PurchaseForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required List<Product> nameList,
    required TextEditingController pieces,
    required TextEditingController ida,
    required TextEditingController name,
    required TextEditingController idProduct,
    required List<User> nameListUser,
    this.product,
    this.user,
  })  : _formKey = formKey,
        _nameList = nameList,
        _nameListUser = nameListUser,
        _name = name,
        _pieces = pieces,
        _ida = ida,
        _idProduct = idProduct;

  final GlobalKey<FormState> _formKey;
  final List<Product> _nameList;
  final List<User> _nameListUser;
  final TextEditingController _pieces;
  final TextEditingController _ida;
  final TextEditingController _name;
  final TextEditingController _idProduct;
  final Product? product;
  final User? user;

  @override
  State<PurchaseForm> createState() => _PurchaseFormState();
}

class _PurchaseFormState extends State<PurchaseForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CustomTextFormField(
          //   controller: widget._name,
          //   labelText: "Product Name",
          //   hintText: 'Enter the product name',
          //   obscureText: false,
          //   keyboardType: TextInputType.name,
          //   icon: Icons.shopping_cart,
          //   validationMessage: 'Please enter a product name',
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
              value: widget.product,
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
                  widget._idProduct.text = value.id!;
                });
              },
              items: widget._nameList.map((Product value) {
                return DropdownMenuItem<Product>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
            ),
          ),
          CustomTextFormField(
            controller: widget._pieces,
            hintText: 'Enter the number of pieces',
            labelText: "Pieces",
            obscureText: false,
            keyboardType: TextInputType.number,
            icon: Icons.format_list_numbered,
            validationMessage: 'Please enter the number of pieces',
          ),
          // CustomTextFormField(
          //   controller: widget._ida,
          //   hintText: 'Enter the IDA',
          //   labelText: "IDA",
          //   obscureText: false,
          //   keyboardType: TextInputType.number,
          //   icon: Icons.person,
          //   validationMessage: 'Please enter an IDA',
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
              value: widget.user,
              hint: const Text('Administrator Name',
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
                  widget._ida.text = value!.name;
                  widget._ida.text = value.id!;
                });
              },
              items: widget._nameListUser.map((User value) {
                return DropdownMenuItem<User>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
