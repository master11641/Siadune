import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import '../api/account_api.dart';
import '../api/upload_image_user.dart';
import '../blocs/bloc_provider.dart';
import '../blocs/user_bloc.dart';
import '../models/user.dart';
import '../pages/login_page.dart';
import '../pages/profile_page.dart';
import '../tools/common_funcs.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({Key key}) : super(key: key);
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  File file;
  @override
  Widget build(BuildContext context) {
    final GlobalKey _menuKey = new GlobalKey();
    // final button = new PopupMenuButton(
    //     key: _menuKey,
    //     itemBuilder: (_) => <PopupMenuItem<String>>[
    //           new PopupMenuItem<String>(
    //               child: const Text('Doge'), value: 'Doge'),
    //           new PopupMenuItem<String>(
    //               child: const Text('Lion'), value: 'Lion'),
    //         ],
    //     onSelected: (_) {});

    // final tile = new ListTile(
    //     title: new Text('Doge or lion?'),
    //     trailing: button,
    //     onTap: () {
    //       // This is a hack because _PopupMenuButtonState is private.
    //       dynamic state = _menuKey.currentState;
    //       state.showButtonMenu();
    //     });
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.firstFetchUser();
    return Builder(
        builder: (context) => StreamBuilder(
              stream: userBloc.outUserController,
              initialData: new User(
                  name: 'کاربر ناشناس',
                  family: '',
                  imageUser: '',
                  imageUserBase64: '',
                  userName: ''),
              builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                return Container(
                  child: Container(
                    child: new Container(
                      constraints: new BoxConstraints.expand(
                        width: MediaQuery.of(context).size.width - 80,
                      ),
                      color: Colors.white,
                      alignment: Alignment.topRight,
                      child: new ListView(
                        padding: EdgeInsets.zero,
                        children: <Widget>[
                          new DrawerHeader(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      GestureDetector(
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          backgroundImage: NetworkImage(
                                              snapshot.data.imageUser),
                                          radius: 30.0,
                                        ),
                                        onTap: () {
                                          //جلوگیری از آپلود فایل زمانی که کاربر لاگین نکرده است
                                          if (snapshot.data.userName == '') {
                                            return;
                                          }
                                          showMenu<String>(
                                            context: context,
                                            position: RelativeRect.fromLTRB(
                                                1000.0, 0.0, 0.0, 0.0),
                                            items: <PopupMenuItem<String>>[
                                              new PopupMenuItem<String>(
                                                  child: const Text('دوربین'),
                                                  value: '0'),
                                              new PopupMenuItem<String>(
                                                  child: const Text('گالری'),
                                                  value: '1'),
                                            ],
                                            elevation: 8.0,
                                          ).then((onValue) {
                                            if (onValue != null) {
                                              switch (onValue) {
                                                case '0':
                                                  // ImagePicker.pickImage(
                                                  //         source: ImageSource.camera)
                                                  //     .then((onValue) {
                                                  //   file = onValue;
                                                  //   _uploadImage(
                                                  //       user: snapshot.data,
                                                  //       userBloc: userBloc,context: context);
                                                  // });
                                                  break;
                                                case '1':
                                                  // ImagePicker.pickImage(
                                                  //         source: ImageSource.gallery)
                                                  //     .then((onValue) {
                                                  //   file = onValue;
                                                  //   _uploadImage(
                                                  //       user: snapshot.data,
                                                  //       userBloc: userBloc,context: context);
                                                  // });
                                                  break;
                                                default:
                                              }
                                            }
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data.name +
                                            ' ' +
                                            snapshot.data.family,
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data.userName,
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              decoration:
                                  new BoxDecoration(color: Colors.blueAccent)),
                          (snapshot.data.userName != '')
                              ? ListTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        "پروفایل",
                                        style: TextStyle(
                                            fontFamily: 'IRANSansMobile'),
                                      ),
                                    ],
                                  ),
                                  trailing: new Icon(Icons.settings),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return ProfilePage(
                                        key: Key(
                                            'profile_${snapshot.data.userName}'),
                                        user: snapshot.data,
                                      );
                                    }));
                                  },
                                )
                              : new ListTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        "ورود",
                                        style: TextStyle(
                                            fontFamily: 'IRANSansMobile'),
                                      ),
                                    ],
                                  ),
                                  trailing: new Icon(Icons.lock_open),
                                  onTap: () {
                                    Navigator.of(context).pushNamed('/login');
                                  }),
                          ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  'ثبت نام',
                                  style:
                                      TextStyle(fontFamily: 'IRANSansMobile'),
                                ),
                              ],
                            ),
                            trailing: new Icon(Icons.verified_user),
                            onTap: () {
                              Navigator.of(context).pushNamed('/register');
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ));
  }

  void _uploadImage({User user, UserBloc userBloc, BuildContext context}) {
    uploadFile(file).then((onValue) {
      showSnackBar(context, 'آپلود شد ');
      accountApi
          .updateUserClimes(
              name: user.name, family: user.family, imageUser: onValue)
          .then((response) {
        showAlert(context, response.message);
        userBloc.updateUser();
      });
    }).catchError((onError) {
      showSnackBar(context, onError.toString(), Colors.red);
    });
  }
}
