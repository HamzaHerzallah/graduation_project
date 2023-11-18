class BuyerModel {
  BuyerModel({this.email, this.username, this.cart, this.profilePicture});

  String? email;
  String? username;
  List<dynamic>? cart;
  String? profilePicture;

  BuyerModel.fromMap(Map<String, dynamic> data)
      : assert(data.isNotEmpty),
        email = data['email'],
        username = data['username'],
        cart = data['cart'],
        profilePicture = data['profilePicture'];

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['username'] = username;
    data['cart'] = cart;
    data['profilePicture'] = profilePicture;
    return data;
  }
}
