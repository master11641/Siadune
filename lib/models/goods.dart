class Goods {
  int id;
  String storeTitle;
  String title;
  String description;
  int goodsStatus;
  int goodsType;
  String summary;
  List<TgoodsImages> tgoodsImages;
  List<Prices> prices;
  double price;
  List<Attributes> attributes;
  Goods(
      {this.id,
      this.storeTitle,
      this.title,
      this.description,
      this.goodsStatus,
      this.goodsType,
      this.summary,
      this.tgoodsImages,
      this.prices,
      this.attributes,
      this.price});

  Goods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeTitle = json['storeTitle'];
    title = json['title'];
    description = json['description'];
    goodsStatus = json['goodsStatus'];
    goodsType = json['goodsType'];
    summary = json['abstract'];
    if (json['tgoodsImages'] != null) {
      tgoodsImages = new List<TgoodsImages>();
      json['tgoodsImages'].forEach((v) {
        tgoodsImages.add(new TgoodsImages.fromJson(v));
      });
    }
    if (json['prices'] != null  ) {
      prices = new List<Prices>();
      json['prices'].forEach((v) {
        prices.add(new Prices.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = new List<Attributes>();
      json['attributes'].forEach((v) {
        attributes.add(new Attributes.fromJson(v));
      });
    }
    price = json['price'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['StoreTitle'] = this.storeTitle;
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['GoodsStatus'] = this.goodsStatus;
    data['GoodsType'] = this.goodsType;
    data['Abstract'] = this.summary;
    if (this.tgoodsImages != null) {
      data['TgoodsImages'] = this.tgoodsImages.map((v) => v.toJson()).toList();
    }
    if (this.prices != null) {
      data['Prices'] = this.prices.map((v) => v.toJson()).toList();
    }
    if (this.attributes != null) {
      data['Attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    data['Price'] = this.price;
    return data;
  }
}

class TgoodsImages {
  String imageUrl;

  TgoodsImages({this.imageUrl});

  TgoodsImages.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ImageUrl'] = this.imageUrl;
    return data;
  }
}

class Prices {
  double price;
  String date;

  Prices({this.price, this.date});

  Prices.fromJson(Map<String, dynamic> json) {
    price = json['price'].toDouble();
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Price'] = this.price;
    data['Date'] = this.date;
    return data;
  }
}
class Attributes {
  String name;
  int tattributeType;
  bool required;
  int attributeId;
  List<AttributeValues> attributeValues;

  Attributes(
      {this.name,
      this.tattributeType,
      this.required,
      this.attributeId,
      this.attributeValues});

  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    tattributeType = json['tattributeType'];
    required = json['required'];
    attributeId = json['attributeId'];
    if (json['attributeValues'] != null) {
      attributeValues = new List<AttributeValues>();
      json['attributeValues'].forEach((v) {
        attributeValues.add(new AttributeValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['TattributeType'] = this.tattributeType;
    data['Required'] = this.required;
    data['AttributeId'] = this.attributeId;
    if (this.attributeValues != null) {
      data['attributeValues'] =
          this.attributeValues.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttributeValues {
  String value;
  int valueId;
  String caption;

  AttributeValues({this.value, this.valueId});

  AttributeValues.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    valueId = json['valueId'];
    caption=json['caption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Value'] = this.value;
    data['ValueId'] = this.valueId;
    data['Caption']=this.caption;
    return data;
  }
}