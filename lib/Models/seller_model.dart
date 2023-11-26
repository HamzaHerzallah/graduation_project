class SellerModel {
  SellerModel(
      {this.email,
      this.username,
      this.phoneNumber,
      this.projectName,
      this.profilePicture,
      this.category,
      this.sellerId});

  String? email;
  String? sellerId;
  String? username;
  String? phoneNumber;
  String? profilePicture;
  String? category;
  String? projectName;

  SellerModel.fromMap(Map<String, dynamic> data)
      : assert(data.isNotEmpty),
        email = data['email'],
        username = data['username'],
        phoneNumber = data['phoneNumber'],
        projectName = data['projectName'],
        profilePicture = data['profilePicture'],
        sellerId = data['sellerId'],
        category = data['category'];

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['username'] = username;
    data['phoneNumber'] = phoneNumber;
    data['projectName'] = projectName;
    data['profilePicture'] = profilePicture;
    data['sellerId'] = sellerId;
    data['category'] = category;
    return data;
  }
}
