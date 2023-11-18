class ItemModel {
  ItemModel(
      {this.sellerId, this.itemId, this.description, this.title, this.price});

  String? sellerId;
  String? itemId;
  String? title;
  String? price;
  String? description;

  ItemModel.fromMap(Map<String, dynamic> data)
      : assert(data.isNotEmpty),
        sellerId = data['sellerId'],
        itemId = data['itemId'],
        title = data['title'],
        price = data['price'],
        description = data['description'];

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sellerId'] = sellerId;
    data['itemId'] = itemId;
    data['title'] = title;
    data['price'] = price;
    data['description'] = description;
    return data;
  }
}
