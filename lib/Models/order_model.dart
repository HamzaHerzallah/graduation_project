class OrderModel {
  OrderModel(
      {this.buyerId,
      this.sellerId,
      this.orderId,
      this.items,
      this.orderStatus});

  String? sellerId;
  String? buyerId;
  String? orderId;
  String? orderStatus;
  List<dynamic>? items;

  OrderModel.fromMap(Map<String, dynamic> data)
      : assert(data.isNotEmpty),
        sellerId = data['sellerId'],
        buyerId = data['buyerId'],
        orderId = data['orderId'],
        orderStatus = data['orderStatus'],
        items = data['items'];

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sellerId'] = sellerId;
    data['buyerId'] = buyerId;
    data['orderId'] = orderId;
    data['orderStatus'] = orderStatus;
    data['items'] = items;
    return data;
  }
}
