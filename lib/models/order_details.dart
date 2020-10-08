
// class OrderDetails {
//   int id;
//   String userMobile;
//   String userFullName;
//   String address;
//   int goodsId;
//   String goodsTitle;
//   List<Attributes> attributes;
//   String goodsImage;
//   int torderStatus;
//   String orderDateInPersian;
//   String orderDate;

//   OrderDetails(
//       {this.id,
//       this.userMobile,
//       this.userFullName,
//       this.address,
//       this.goodsId,
//       this.goodsTitle,
//       this.attributes,
//       this.goodsImage,
//       this.torderStatus,
//       this.orderDateInPersian,
//       this.orderDate});

//   OrderDetails.fromJson(Map<String, dynamic> json) {
//     id = json['Id'];
//     userMobile = json['UserMobile'];
//     userFullName = json['UserFullName'];
//     address = json['Address'];
//     goodsId = json['GoodsId'];
//     goodsTitle = json['GoodsTitle'];
//     if (json['Attributes'] != null) {
//       attributes = new List<Attributes>();
//       json['Attributes'].forEach((v) {
//         attributes.add(new Attributes.fromJson(v));
//       });
//     }
//     goodsImage = json['GoodsImage'];
//     torderStatus = json['TorderStatus'];
//     orderDateInPersian = json['orderDateInPersian'];
//     orderDate = json['OrderDate'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Id'] = this.id;
//     data['UserMobile'] = this.userMobile;
//     data['UserFullName'] = this.userFullName;
//     data['Address'] = this.address;
//     data['GoodsId'] = this.goodsId;
//     data['GoodsTitle'] = this.goodsTitle;
//     if (this.attributes != null) {
//       data['Attributes'] = this.attributes.map((v) => v.toJson()).toList();
//     }
//     data['GoodsImage'] = this.goodsImage;
//     data['TorderStatus'] = this.torderStatus;
//     data['orderDateInPersian'] = this.orderDateInPersian;
//     data['OrderDate'] = this.orderDate;
//     return data;
//   }
// }

// class Attributes {
//   int id;
//   String name;
//   String value;
//   int tattributeType;
//   String caption;

//   Attributes(
//       {this.id, this.name, this.value, this.tattributeType, this.caption});

//   Attributes.fromJson(Map<String, dynamic> json) {
//     id = json['Id'];
//     name = json['Name'];
//     value = json['Value'];
//     tattributeType = json['TattributeType'];
//     caption = json['Caption'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Id'] = this.id;
//     data['Name'] = this.name;
//     data['Value'] = this.value;
//     data['TattributeType'] = this.tattributeType;
//     data['Caption'] = this.caption;
//     return data;
//   }
// }


class OrderDetails {
  int id;
  String userMobile;
  String userFullName;
  CustomerOrderAddress customerOrderAddress;
  int goodsId;
  String goodsTitle;
  List<Attributes> attributes;
  String goodsImage;
  int torderStatus;
  String orderDateInPersian;
  String orderDate;

  OrderDetails(
      {this.id,
      this.userMobile,
      this.userFullName,
      this.customerOrderAddress,
      this.goodsId,
      this.goodsTitle,
      this.attributes,
      this.goodsImage,
      this.torderStatus,
      this.orderDateInPersian,
      this.orderDate});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userMobile = json['UserMobile'];
    userFullName = json['UserFullName'];
    customerOrderAddress = json['CustomerOrderAddress'] != null
        ? new CustomerOrderAddress.fromJson(json['CustomerOrderAddress'])
        : null;
    goodsId = json['GoodsId'];
    goodsTitle = json['GoodsTitle'];
    if (json['Attributes'] != null) {
      attributes = new List<Attributes>();
      json['Attributes'].forEach((v) {
        attributes.add(new Attributes.fromJson(v));
      });
    }
    goodsImage = json['GoodsImage'];
    torderStatus = json['TorderStatus'];
    orderDateInPersian = json['orderDateInPersian'];
    orderDate = json['OrderDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['UserMobile'] = this.userMobile;
    data['UserFullName'] = this.userFullName;
    if (this.customerOrderAddress != null) {
      data['CustomerOrderAddress'] = this.customerOrderAddress.toJson();
    }
    data['GoodsId'] = this.goodsId;
    data['GoodsTitle'] = this.goodsTitle;
    if (this.attributes != null) {
      data['Attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    data['GoodsImage'] = this.goodsImage;
    data['TorderStatus'] = this.torderStatus;
    data['orderDateInPersian'] = this.orderDateInPersian;
    data['OrderDate'] = this.orderDate;
    return data;
  }
}

class CustomerOrderAddress {
  int addressId;
  String fullAddress;
  int cityId;
  String mobileDeliver;
  String nameDeliver;
  String cityName;
  String longitude;
  String latitude;

  CustomerOrderAddress(
      {this.fullAddress,
      this.cityId,
      this.mobileDeliver,
      this.nameDeliver,
      this.cityName,
      this.longitude,
      this.latitude});

  CustomerOrderAddress.fromJson(Map<String, dynamic> json) {
    addressId = json['addressId'];
    fullAddress = json['fullAddress'];
    cityId = json['cityId'];
    mobileDeliver = json['mobileDeliver'];
    nameDeliver = json['nameDeliver'];
    cityName = json['cityName'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FullAddress'] = this.fullAddress;
    data['CityId'] = this.cityId;
    data['MobileDeliver'] = this.mobileDeliver;
    data['NameDeliver'] = this.nameDeliver;
    data['CityName'] = this.cityName;
    data['Longitude'] = this.longitude;
    data['Latitude'] = this.latitude;
    return data;
  }
}

class Attributes {
  int id;
  String name;
  String value;
  int tattributeType;
  String caption;

  Attributes(
      {this.id, this.name, this.value, this.tattributeType, this.caption});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    value = json['Value'];
    tattributeType = json['TattributeType'];
    caption = json['Caption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Value'] = this.value;
    data['TattributeType'] = this.tattributeType;
    data['Caption'] = this.caption;
    return data;
  }
}