// class User {
//   String name;
//   String family;
//   String imageUser;
//   String imageUserBase64;
//   String userName;

//   User({this.name, this.family, this.imageUser, this.imageUserBase64,this.userName});

//   User.fromJson(Map<String, dynamic> json) {
//     name = (json['Name']==null)?'':json['Name'];
//     family = (json['Family']==null)?'':json['Family'];
//     imageUser = json['ImageUser'];
//     imageUserBase64 = json['ImageUserBase64'];
//     userName=json['UserName'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Name'] = this.name;
//     data['Family'] = this.family;
//     data['ImageUser'] = this.imageUser;
//     data['ImageUserBase64'] = this.imageUserBase64;
//     data['UserName']=this.userName;
//     return data;
//   }
// }

import 'order_details.dart';

class User {
  String name;
  String family;
  List<CustomerOrderAddress> customerOrderAddress;
  String imageUser;
  String imageUserBase64;
  String userName;
  String token;

  User(
      {this.name,
      this.family,
      this.customerOrderAddress,
      this.imageUser,
      this.imageUserBase64,
      this.userName,
      this.token});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    family = json['family'];
    if (json['customerOrderAddress'] != null) {
      customerOrderAddress = new List<CustomerOrderAddress>();
      json['customerOrderAddress'].forEach((v) {
        customerOrderAddress.add(new CustomerOrderAddress.fromJson(v));
      });
    }
    imageUser = json['imageUser'];
    imageUserBase64 = json['imageUserBase64'];
    userName = json['userName'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['family'] = this.family;
    if (this.customerOrderAddress != null) {
      data['CustomerOrderAddress'] =
          this.customerOrderAddress.map((v) => v.toJson()).toList();
    }
    data['ImageUser'] = this.imageUser;
    data['ImageUserBase64'] = this.imageUserBase64;
    data['UserName'] = this.userName;
    data['Token'] = this.token;
    return data;
  }
}