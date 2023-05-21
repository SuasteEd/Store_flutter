import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examen_2p/alerts/alert_error.dart';
import 'package:examen_2p/models/users_model.dart';
import 'package:examen_2p/theme/app_theme.dart';
import 'package:examen_2p/widgets/custom_button.dart';
import 'package:examen_2p/widgets/custom_circle_avatar.dart';
import 'package:examen_2p/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../alerts/alert_successful.dart';
import '../controllers/data_controller.dart';
import '../widgets/custom_text_form_field.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final _name = TextEditingController();
  final _lastName = TextEditingController();
  final _age = TextEditingController();
  final _gender = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _role = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPressed = false;
  final _controller = Get.put(DataController());
  @override
  Widget build(BuildContext context) {
    final User? args = ModalRoute.of(context)?.settings.arguments as User?;
    if (args != null) {
      _name.text = args.name;
      _lastName.text = args.lastName;
      _age.text = args.age.toString();
      _gender.text = args.gender.toString();
      _email.text = args.email;
      _password.text = args.password;
      _role.text = args.role;
    }
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
                  genderFromList: args?.gender,
                  roleFromList: args?.role,
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
                    : Text(
                        args == null ? 'Save' : 'Update',
                        style: AppTheme.textButton,
                      ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _isPressed = true;
                    final user = User(
                        id: args?.id,
                        name: _name.text,
                        lastName: _lastName.text,
                        age: int.parse(_age.text),
                        gender: _gender.text,
                        email: _email.text,
                        password: _password.text,
                        role: _role.text);
                    if (args == null) {
                      if (await _controller.addUser(user)) {
                        _isPressed = false;
                        setState(() {});
                        // ignore: use_build_context_synchronously
                        alertSucces(context, 'User saved successfully!');
                      } else {
                        _isPressed = false;
                        setState(() {});
                        // ignore: use_build_context_synchronously
                        alertError(context, 'Error saving user!');
                      }
                    } else {
                      if (await _controller.updateUser(user)) {
                        _isPressed = false;
                        setState(() {});
                        // ignore: use_build_context_synchronously
                        alertSucces(context, 'User updated successfully!');
                      } else {
                        _isPressed = false;
                        setState(() {});
                        // ignore: use_build_context_synchronously
                        alertError(context, 'Error updating user!');
                      }
                    }
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
    this.genderFromList,
    this.roleFromList,
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
  final String? genderFromList;
  final String? roleFromList;

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  List<String> genderOptions = ['Female', 'Male', 'Other'];
  List<String> roleOptions = ['Admin', 'Vendor', 'Customer'];
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
            child: DropdownButtonFormField(
              value: widget.genderFromList,
              hint: const Text('Gender', style: TextStyle(color: Colors.black)),
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
                  widget._gender.text = value!;
                });
              },
              items:
                  genderOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
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
            child: DropdownButtonFormField(
              value: widget.roleFromList,
              hint: const Text('Role', style: TextStyle(color: Colors.black)),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                icon: Icon(
                  Icons.person_pin,
                  color: Colors.black,
                ),
              ),
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  widget._role.text = value!;
                });
              },
              items: roleOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
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
