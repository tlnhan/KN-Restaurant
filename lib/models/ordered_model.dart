class OrderHistory {
  final String userName;
  final List<Map<String, dynamic>> orderItems;
  final String numberPhone;
  final String address;
  final String cashPayment;
  final DateTime createdAt;
  final String status;
  final String email;

  OrderHistory({
    required this.userName,
    required this.orderItems,
    required this.numberPhone,
    required this.address,
    required this.cashPayment,
    required this.createdAt,
    required this.status,
    required this.email,
  });
}
