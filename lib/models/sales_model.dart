class Sale {
  String? id;
  String productId;
  String costumerId;
  String productName;
  String vendorId;
  double amount;
  double pieces;
  double subtotal;
  double total;

  Sale(
      {this.id,
        required this.productId,
      required this.costumerId,
      required this.productName,
      required this.vendorId,
      required this.amount,
      required this.pieces,
      required this.subtotal,
      required this.total});
}
