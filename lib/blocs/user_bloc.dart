import '../api/account_api.dart';
import '../blocs/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import '../models/user.dart';

class UserBloc extends BlocBase {
  User user;
  ReplaySubject<User> _userController = ReplaySubject<User>();
  Sink<User> get _inUserController => _userController.sink;
  Stream<User> get outUserController => _userController.stream;
  void updateUser() {
    accountApi.getUser().then((user) {
      this.user = user;
      _inUserController.add(user);
    }).catchError((err) {
      print(err.toString());
    });
  }

  void firstFetchUser() {
    if (user == null) {
      updateUser();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
