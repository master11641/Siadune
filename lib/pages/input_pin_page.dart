
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:progress_dialog/progress_dialog.dart' as progress;
import '../api/account_api.dart';
import '../blocs/bloc_provider.dart';
import '../blocs/user_bloc.dart';
import '../models/login_result.dart';
import '../pages/home_page.dart';
import '../tools/common_funcs.dart';
import '../tools/preferences.dart';

class InputPintPage extends StatefulWidget {
  const InputPintPage({Key key, this.code, this.mobileNumber}) : super(key: key);
  final String code;
  final String mobileNumber;
  @override
  _InputPintPageState createState() => _InputPintPageState();
}

class _InputPintPageState extends State<InputPintPage> {
 // progress.ProgressDialog pr;
  
  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);  
    //pr = new progress.ProgressDialog(context,progress.ProgressDialogType.Normal);
   // pr=new progress.ProgressDialog(context);
   // pr.setMessage('لطفا صبر کنید...');
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'تایید کد',
            style: TextStyle(fontFamily: Preferences.fontName),
          ),
        ),
        body: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(40.0),
            child: Center(
              child: PinPut(
                fieldsCount: 4,
                onSubmit: (String pin) async {
                  if (pin == widget.code)
                    {   
                     //  pr.show();     
                       LoginResult result=await accountApi.login(username: widget.mobileNumber,password: pin);
                       if(result.success){
                          userBloc.updateUser(); 
                              Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return HomePage();
                        }));
                       }
                        // showAlert(context, result.message);
                        Future.delayed(Duration(seconds: 2)).then((onvalue) => {
                        //  pr.hide();
                        });
                      }
                  else
                    {
                      showSnackBar(
                          context, 'مقدار وارد شده صحیح نمی باشد', Colors.red);
                    }
                },
                onClear: (String pin) => pin = '',
              ),
            ),
          ),
        ));
  }
}
