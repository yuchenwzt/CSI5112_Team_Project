class User {
  final String first_name;
  final String last_name;
  final String email;
  final String username;
  final String password;
  final String phone;
  final String merchant_id;
  final String customer_id;
  final bool isMerchant;

  User({
    this.customer_id = "",
    this.merchant_id = "",
    this.first_name = "",
    this.last_name = "",
    this.email = "",
    this.password = "",
    this.username = "",
    this.phone = "",
    this.isMerchant = true
  });

  User.fromList(List<dynamic> list, bool merchant) 
    : first_name = list[0]['first_name'],
      last_name = list[0]['last_name'],
      email = list[0]['email'],
      password = list[0]['password'],
      username = list[0]['username'],
      phone = list[0]['phone'],
      isMerchant = merchant,
      customer_id = merchant ? "" : list[0]['customer_id'],
      merchant_id = merchant ? list[0]['merchant_id'] : "";
}