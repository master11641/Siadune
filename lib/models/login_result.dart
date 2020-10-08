class LoginResult {
  final bool success;
  final String message;
  LoginResult({this.success, this.message});
  factory LoginResult.fromJson(Map<String, dynamic> parsedJson) {
    return LoginResult(success: parsedJson["Success"], message: parsedJson["Message"]);
  }
}
class LoginCheckResult {
  bool status;
  bool userExistBefore;
  String returnCode;

  LoginCheckResult({this.status, this.userExistBefore, this.returnCode});

  LoginCheckResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userExistBefore = json['userExistBefore'];
    returnCode = json['returnCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['userExistBefore'] = this.userExistBefore;
    data['returnCode'] = this.returnCode;
    return data;
  }
}