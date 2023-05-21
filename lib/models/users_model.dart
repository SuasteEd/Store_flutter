class User {
  String name;
  String lastName;
  String? id;
  int age;
  String gender;
  String email;
  String password;
  String role;

  User({
    required this.name,
    required this.lastName,
    this.id,
    required this.age,
    required this.gender,
    required this.email,
    required this.password,
    required this.role,
  });
}
