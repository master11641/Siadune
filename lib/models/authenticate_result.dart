class AuthenticateResult {
  int id;
  String firstName;
  Null lastName;
  String username;
  String token;

  AuthenticateResult(
      {this.id, this.firstName, this.lastName, this.username, this.token});

  AuthenticateResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['username'] = this.username;
    data['token'] = this.token;
    return data;
  }
}