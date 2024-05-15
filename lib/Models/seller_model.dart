class SellerModel {
  SellerModel({
    this.email,
    this.username,
    this.phoneNumber,
    this.projectName,
    this.profilePicture,
    this.category,
    this.chats,
    this.sellerId,
    this.sellerUID,
    this.rating,
    this.ratingCount,
  });

  String? email;
  String? sellerId;
  String? sellerUID;
  String? username;
  String? phoneNumber;
  String? profilePicture;
  String? category;
  List<dynamic>? chats;
  String? projectName;
  String? rating;
  String? ratingCount;
  String? ratingSum;

  SellerModel.fromMap(Map<String, dynamic> data)
      : assert(data.isNotEmpty),
        email = data['email'],
        username = data['username'],
        phoneNumber = data['phoneNumber'],
        projectName = data['projectName'],
        profilePicture = data['profilePicture'],
        sellerId = data['sellerId'],
        sellerUID = data['sellerUID'],
        category = data['category'],
        chats = data['chats'],
        rating = data['rating'],
        ratingCount = data['ratingCount'],
        ratingSum = data['ratingSum'];

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['username'] = username;
    data['phoneNumber'] = phoneNumber;
    data['projectName'] = projectName;
    data['profilePicture'] = profilePicture;
    data['sellerId'] = sellerId;
    data['sellerUID'] = sellerUID;
    data['chats'] = chats;
    data['category'] = category;
    data['rating'] = rating;
    data['ratingCount'] = ratingCount;
    data['ratingSum'] = ratingSum;
    return data;
  }
}
