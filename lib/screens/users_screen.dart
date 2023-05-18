import 'package:examen_2p/theme/app_theme.dart';
import 'package:examen_2p/widgets/custom_button.dart';
import 'package:examen_2p/widgets/custom_circle_avatar.dart';
import 'package:examen_2p/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import '../alerts/alert_successful.dart';
import '../widgets/custom_text_form_field.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final _id = TextEditingController();
  final _name = TextEditingController();
  final _lastName = TextEditingController();
  final _age = TextEditingController();
  final _gender = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _role = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users Screen'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const CustomCircleAvatar(
                  tag: 'user', json: 'assets/json/user.json'),
              const SizedBox(height: 20),
              UserForm(
                  formKey: _formKey,
                  name: _name,
                  lastName: _lastName,
                  age: _age,
                  gender: _gender,
                  email: _email,
                  password: _password,
                  role: _role),
              CustomButton(
                text: _isPressed
                    ? const LoadingButton()
                    : const Text(
                        'Save',
                        style: AppTheme.textButton,
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserForm extends StatefulWidget {
  const UserForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController name,
    required TextEditingController lastName,
    required TextEditingController age,
    required TextEditingController gender,
    required TextEditingController email,
    required TextEditingController password,
    required TextEditingController role,
  })  : _formKey = formKey,
        _name = name,
        _lastName = lastName,
        _age = age,
        _gender = gender,
        _email = email,
        _password = password,
        _role = role;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _name;
  final TextEditingController _lastName;
  final TextEditingController _age;
  final TextEditingController _gender;
  final TextEditingController _email;
  final TextEditingController _password;
  final TextEditingController _role;

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  List<String> genderOptions = ['Gender', 'Female', 'Male', 'Other'];
  String selectedGender = 'Gender';
  List<String> roleOptions = ['Role', 'Admin', 'User'];
  String selectedRole = 'Role';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormField(
            controller: widget._name,
            labelText: "Name",
            hintText: 'Enter your name',
            keyboardType: TextInputType.name,
            icon: Icons.person,
            obscureText: false,
            validationMessage: 'Please enter a name',
          ),
          CustomTextFormField(
            controller: widget._lastName,
            labelText: "Last Name",
            hintText: 'Enter your last name',
            keyboardType: TextInputType.name,
            obscureText: false,
            icon: Icons.person_outline,
            validationMessage: 'Please enter a last name',
          ),
          CustomTextFormField(
            controller: widget._age,
            labelText: "Age",
            hintText: 'Enter your age',
            obscureText: false,
            icon: Icons.cake,
            keyboardType: TextInputType.number,
            validationMessage: 'Please enter your age',
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
            child: DropdownButton(
              value: selectedGender, // valor seleccionado
              underline: Container(),
              isExpanded: true,
              // hint: const Text(
              //     'Selecciona tu género'), // texto que se muestra antes de seleccionar
              onChanged: (String? newValue) {
                // cuando el usuario seleccione una opción, se actualiza el valor seleccionado
                setState(() {
                  selectedGender = newValue!;
                  widget._role.text = selectedGender;
                });
              },
              items:
                  genderOptions.map<DropdownMenuItem<String>>((String value) {
                // crea los elementos de la lista de opciones del DropDownButton
                return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(width: 10),
                        Text(value),
                      ],
                    ));
              }).toList(),
            ),
          ),
          CustomTextFormField(
            controller: widget._email,
            labelText: "Email",
            hintText: 'Enter your email',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
            validationMessage: 'Please enter a valid email',
          ),
          CustomTextFormField(
            controller: widget._password,
            labelText: "Password",
            hintText: 'Enter your password',
            icon: Icons.lock,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            validationMessage: 'Please enter a password',
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
            child: DropdownButton(
              value: selectedRole, // valor seleccionado
              underline: Container(),
              isExpanded: true,
              // hint: const Text(
              //     'Selecciona tu género'), // texto que se muestra antes de seleccionar
              onChanged: (String? newValue) {
                // cuando el usuario seleccione una opción, se actualiza el valor seleccionado
                setState(() {
                  selectedRole = newValue!;
                  widget._role.text = selectedRole;
                });
              },
              items:
                  roleOptions.map<DropdownMenuItem<String>>((String value) {
                // crea los elementos de la lista de opciones del DropDownButton
                return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        const Icon(Icons.admin_panel_settings_rounded),
                        const SizedBox(width: 10),
                        Text(value),
                      ],
                    ));
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
