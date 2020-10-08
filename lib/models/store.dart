class Store{
 int id;
  String title;
  String imageUrl;
  String address;
  bool isFreeDeliveryExist;
  int tcategoryStoreId;
  String logoImageUrl;

  Store(
      {this.id,
      this.title,
      this.imageUrl,
      this.address,
      this.isFreeDeliveryExist,
      this.logoImageUrl,
      this.tcategoryStoreId});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageUrl = json['imageUrl'];
    address = json['address'];
logoImageUrl=json['logoImageUrl'];
    isFreeDeliveryExist = json['isFreeDeliveryExist'];
    tcategoryStoreId = json['tcategoryStoreId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Title'] = this.title;
    data['ImageUrl'] = this.imageUrl;
    data['Address'] = this.address;
    data['logoImageUrl']=this.logoImageUrl;
    data['IsFreeDeliveryExist'] = this.isFreeDeliveryExist;
    data['TcategoryStoreId'] = this.tcategoryStoreId;
    return data;
  }
}