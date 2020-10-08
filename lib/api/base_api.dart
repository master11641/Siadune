class BaseApi {
  //static const String baseUrl = 'http://192.168.1.113:5000';
  static const String baseUrl = 'http://persianprogrammer.ir';
  static const String averUrl = '$baseUrl/advers/getadvers';
  static const String loginUrl = '$baseUrl/account/loginmobile';
   static const String registerUrl = '$baseUrl/auth/Users/Register';
  static const String loginCheckUrl = '$baseUrl/account/LoginMobileByPhoneNumber';
  static const String storeUrl = '$baseUrl/Stores/getstores';
  static const String goodsUrl = '$baseUrl/Goods/GetGoodsByStoreId';
  static const String currentUserUrl = '$baseUrl/Auth/Users/GetCurrentUser';
  static const String updateUserClimesUrl = '$baseUrl/account/updateclimes';
  static const String orderRegisterUrl = '$baseUrl/orders/create';
  static const String orderDetailsUrl = '$baseUrl/TicketYar/Torder/getbyid';
}

