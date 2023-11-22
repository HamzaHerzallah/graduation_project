class BuyerModel {
  BuyerModel(
      {this.email,
      this.username,
      this.cart,
      this.profilePicture,
      this.buyerId});

  String? email;
  String? buyerId;
  String? username;
  List<dynamic>? cart;
  String? profilePicture;

  BuyerModel.fromMap(Map<String, dynamic> data)
      : assert(data.isNotEmpty),
        email = data['email'],
        buyerId = data['buyerId'],
        username = data['username'],
        cart = data['cart'],
        profilePicture = data['profilePicture'];

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['buyerId'] = buyerId;
    data['username'] = username;
    data['cart'] = cart;
    data['profilePicture'] = profilePicture;
    return data;
  }
}
