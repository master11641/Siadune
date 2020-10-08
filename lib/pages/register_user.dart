import 'package:flutter/material.dart';

class RegisterUserPage extends StatefulWidget {
  RegisterUserPage({Key key}) : super(key: key);

  @override
  _RegisterUserPageState createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  TextEditingController nameTxt = TextEditingController();
  TextEditingController mobileTxt = TextEditingController();
  TextEditingController passTxt = TextEditingController();
  TextEditingController passConfirmTxt = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ثبت نام'),),
      body: SafeArea(
        child: Container(
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                      ListTile(
                        title: TextFormField(
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                          onTap: () {
                           // showWeightBottomSheet();
                          },
                          controller: nameTxt,
                          enableInteractiveSelection: false,
                          readOnly: true,
                          //obscureText: true,
                          decoration: InputDecoration(
                            // border: InputBorder.none,
                            labelText: '',
                          ),
                        ),
                        leading: Icon(Icons.screen_lock_landscape)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
