import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../api/account_api.dart';
import '../models/login_result.dart';
import '../pages/input_pin_page.dart';
import '../tools/common_funcs.dart';
import '../tools/preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blueAccent, Colors.lightBlueAccent],
                  ),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(90))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: 32,
                        ),
                        child: Icon(
                          Icons.mobile_screen_share,
                          size: 90,
                          color: Colors.white,
                        ),
                      )),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 32, right: 32),
                      child: Text(
                        'تایید شماره همراه',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: Preferences.fontName),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 62),
              child: Column(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.only(top: 4, left: 25, right: 25, bottom: 4),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'شماره موبایل خود را وارد نمایید';
                        }
                        return null;
                      },
                      controller: userNameController,
                      decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        hintText: 'شماره موبایل',
                        alignLabelWithHint: true,
                      ),
                    ),
                  ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width / 1.2,
                  //   height: 45,
                  //   margin: EdgeInsets.only(top: 32),
                  //   padding:
                  //       EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.all(Radius.circular(50)),
                  //       color: Colors.white,
                  //       boxShadow: [
                  //         BoxShadow(color: Colors.black12, blurRadius: 5)
                  //       ]),
                  //   child: TextFormField(
                  //     controller: passwordController,
                  //     decoration: InputDecoration(
                  //       border: InputBorder.none,
                  //       icon: Icon(
                  //         Icons.vpn_key,
                  //         color: Colors.grey,
                  //       ),
                  //       hintText: 'Password',
                  //     ),
                  //   ),
                  // ),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(top: 16, right: 32),
                  //     child: Text(
                  //       'Forgot Password ?',
                  //       style: TextStyle(color: Colors.grey),
                  //     ),
                  //   ),
                  // ),
                  //Spacer(),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState.validate()) {
                        if ((await accountApi.login(
                                username: userNameController.text,
                                password: passwordController.text))
                            .success) {
                          showAlert(context, 'success');
                        } else {
                          showAlert(context, 'failure');
                        }
                      }
                    },
                    child: GestureDetector(
                      child: Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width / 1.2,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.blueAccent,
                                Colors.lightBlueAccent
                              ],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Center(
                          child: Text(
                            'درخواست کد تایید',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: Preferences.fontName),
                          ),
                        ),
                      ),
                      onTap: () async {
                        LoginCheckResult result = await AccountApi()
                            .loginCheck(mobileNumber: userNameController.text);
                        showAlert(context, result.returnCode);
                        new Future.delayed(const Duration(seconds: 4), () => 
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return InputPintPage(code: result.returnCode,mobileNumber: userNameController.text,);
                        }))
                        );
                      
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
