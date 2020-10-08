class OrderResult {
  int id;
  int count;
  String orderDate;
  int torderStatus;
  String userName;
  String goodsTitle;
  int goodsId;
  String storeTitle;
  int storeId;
  List<String> attributes;

  OrderResult(
      {this.id,
      this.count,
      this.orderDate,
      this.torderStatus,
      this.userName,
      this.goodsTitle,
      this.goodsId,
      this.storeTitle,
      this.storeId,
      this.attributes});

  OrderResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    count = json['count'];
    orderDate = json['orderDate'];
    torderStatus = json['torderStatus'];
    userName = json['userName'];
    goodsTitle = json['goodsTitle'];
    goodsId = json['goodsId'];
    storeTitle = json['storeTitle'];
    storeId = json['storeId'];
    attributes = json['attributes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Count'] = this.count;
    data['OrderDate'] = this.orderDate;
    data['TorderStatus'] = this.torderStatus;
    data['UserName'] = this.userName;
    data['GoodsTitle'] = this.goodsTitle;
    data['GoodsId'] = this.goodsId;
    data['StoreTitle'] = this.storeTitle;
    data['StoreId'] = this.storeId;
    data['Attributes'] = this.attributes;
    return data;
  }
}