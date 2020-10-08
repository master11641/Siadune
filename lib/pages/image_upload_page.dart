import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import '../api/account_api.dart';
import '../blocs/bloc_provider.dart';
import '../blocs/user_bloc.dart';
import '../models/user.dart';
import '../api/upload_image_user.dart';
import '../tools/common_funcs.dart';

class ImageUploadPage extends StatefulWidget {
  ImageUploadPage({Key key, this.user}) : super(key: key);
  final User user;
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  File file;

  @override
  Widget build(BuildContext context) {
       final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
        body: Builder(
            builder: (context) => Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        (file == null)
                            ? Image.network(widget.user.imageUser)
                            : Image.file(file),
                        RaisedButton(
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          onPressed: () {
                            // ImagePicker.pickImage(source: ImageSource.gallery)
                            //     .then((onValue) {
                            //   setState(() {
                            //     file = onValue;
                            //   });
                            // });
                          },
                          child: Text('انتخاب تصویر جدید'),
                        ),
                        SizedBox(width: 10.0),
                        RaisedButton(
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          onPressed: () {
                            uploadFile(file).then((onValue) {
                              showSnackBar(context, 'آپلود شد ');
                              accountApi
                                  .updateUserClimes(
                                      name: widget.user.name,
                                      family: widget.user.family,
                                      imageUser: onValue)
                                  .then((response){
                                    showAlert(context, response.message);
                                    userBloc.updateUser();
                                  });
                            }).catchError((onError) {
                              showSnackBar(
                                  context, onError.toString(), Colors.red);
                            });
                          },
                          child: Text('ثبت تغییرات'),
                        )
                      ],
                    ),
                    file == null ? Text('No Image Selected') : Text(file.path)
                  ],
                )));
  }
}
