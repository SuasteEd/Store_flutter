class Product {
  String? id;
  String name;
  String description;
  double cost;
  double price;
  double units;
  double utility;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.cost,
    required this.price,
    required this.units,
    required this.utility
  });

  

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      cost: map['cost'],
      price: map['price'],
      units: map['units'],
      utility: map['utility'],
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      cost: json['cost'],
      price: json['price'],
      units: json['units'],
      utility: json['utility'],
    );
  }
}