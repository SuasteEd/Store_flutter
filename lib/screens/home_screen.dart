import 'package:animate_do/animate_do.dart';
import 'package:examen_2p/theme/app_theme.dart';
import 'package:examen_2p/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

List<Map<String, dynamic>> cartas = [
  {
    'imagen': 'assets/json/register.json',
    'titulo': 'Register',
    'texto': 'Register users/products',
    'ruta': '',
    'color': Colors.red[200],
  },
  {
    'imagen': 'assets/json/sale.json',
    'titulo': 'Sales',
    'texto': 'Make a sale',
    'ruta': 'sales',
    'color': Colors.green[200],
  },
  {
    'imagen': 'assets/json/purchase.json',
    'titulo': 'Purchase',
    'texto': 'Make a purchase',
    'ruta': 'purchase',
    'color': Colors.blue[200],
  },
  {
    'imagen': 'assets/json/purchase.json',
    'titulo': 'Data',
    'texto': 'Make a purchase',
    'ruta': '',
    'color': Colors.blue[200],
  },
];

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation Screen'),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0),
        child: GridView.count(
          mainAxisSpacing: 16.0, // Espacio entre las cartas
          crossAxisSpacing: 16,
          crossAxisCount: 2,
          children: List.generate(cartas.length, (index) {
            final carta = cartas[index];
            return InkWell(
              onTap: () {
                carta['ruta'] == ''
                    ? carta['titulo'] == 'Data'
                        ? showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDetails(carta: carta);
                            },
                          )
                        : showDialog(
                            context: context,
                            builder: (context) {
                              return AlertRegister(carta: carta);
                            },
                          )
                    : Navigator.of(context).pushNamed(carta['ruta']);
              },
              child: FadeInUp(
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadowColor: Colors.blue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 10.0),
                        child: CircleAvatar(
                            radius: 25,
                            backgroundColor: carta['color'],
                            // child: SvgPicture.asset(
                            //   cartas[index]['imagen'],
                            //   height: 25,
                            //   color: Colors.white,
                            // ),
                            child: Hero(
                              tag: carta['titulo'],
                              child: Lottie.asset(
                                carta['imagen'],
                              ),
                            )),
                      ),
                      ListTile(
                        title: Text(
                          carta['titulo'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        subtitle: Text(
                          cartas[index]['texto'],
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class AlertRegister extends StatelessWidget {
  const AlertRegister({
    super.key,
    required this.carta,
  });

  final Map<String, dynamic> carta;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
          height: 300,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.black,
            ),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'Register',
                child: Lottie.asset(
                  'assets/json/register.json',
                  height: 100,
                ),
              ),
              const Text(
                'Register a',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: AppTheme.secondary,
                  child: Hero(
                    tag: 'user',
                    child: Lottie.asset('assets/json/user.json'),
                  ),
                ),
                title: const Text(
                  'User',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('users');
                },
                trailing: const Icon(Icons.app_registration),
              ),
              const Divider(),
              ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: AppTheme.secondary,
                  child: Hero(
                    tag: 'product',
                    child: Lottie.asset('assets/json/products.json'),
                  ),
                ),
                title: const Text(
                  'Product',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('products');
                },
                trailing: const Icon(Icons.app_registration),
              ),
            ],
          )),
    );
  }
}

class AlertDetails extends StatelessWidget {
  const AlertDetails({
    super.key,
    required this.carta,
  });

  final Map<String, dynamic> carta;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
          height: 450,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.black,
            ),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'Register',
                child: Lottie.asset(
                  'assets/json/register.json',
                  height: 100,
                ),
              ),
              const Text(
                'View a list of',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: AppTheme.secondary,
                  child: Hero(
                    tag: 'user',
                    child: Lottie.asset('assets/json/user.json'),
                  ),
                ),
                title: const Text(
                  'Users',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('users_list');
                },
                trailing: const Icon(Icons.app_registration),
              ),
              const Divider(),
              ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: AppTheme.secondary,
                  child: Hero(
                    tag: 'product',
                    child: Lottie.asset('assets/json/products.json'),
                  ),
                ),
                title: const Text(
                  'Products',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('products_list');
                },
                trailing: const Icon(Icons.app_registration),
              ),
              const Divider(),
              ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: AppTheme.secondary,
                  child: Hero(
                    tag: 'product',
                    child: Lottie.asset('assets/json/products.json'),
                  ),
                ),
                title: const Text(
                  'Sales',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('sales_list');
                },
                trailing: const Icon(Icons.app_registration),
              ),
              const Divider(),
              ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: AppTheme.secondary,
                  child: Hero(
                    tag: 'product',
                    child: Lottie.asset('assets/json/products.json'),
                  ),
                ),
                title: const Text(
                  'Purchases',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('purchase_list');
                },
                trailing: const Icon(Icons.app_registration),
              ),
            ],
          )),
    );
  }
}
