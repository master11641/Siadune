import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../api/account_api.dart';
import '../blocs/bloc_provider.dart';
import '../blocs/user_bloc.dart';
import '../models/user.dart';
import '../tools/common_funcs.dart';
import '../tools/preferences.dart';

// Create a Form widget.
class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({Key key, this.user}) : super(key: key);
  @override
  ProfilePageState createState() {
    return ProfilePageState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class ProfilePageState extends State<ProfilePage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final familyController = TextEditingController();
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
        nameController.text = widget.user.name;
    familyController.text = widget.user.family;
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    familyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    return Scaffold(
      body: Builder(
          builder: (context) => CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    floating: false,
                    expandedHeight: 150,
                    pinned: true,
                    backgroundColor: Colors.blueAccent,
                    flexibleSpace: FlexibleSpaceBar(
                      title: _buildHeader(widget.user),
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.add_circle),
                        tooltip: 'Add new entry',
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SliverFillRemaining(
                    child: Form(
                        key: _formKey,
                        child: Card(
                            child: Padding(
                          padding: EdgeInsets.only(
                              right: 20, left: 20, top: 15, bottom: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              TextFormField(
                                // initialValue: widget.user.name,
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                controller: nameController,
                                decoration: InputDecoration(
                                  hintText: 'نام',
                                  hintStyle: TextStyle(
                                      fontFamily: Preferences.fontName),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'نام را وارد کنید';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                // initialValue: widget.user.family,
                                controller: familyController,
                                decoration: InputDecoration(
                                    hintText: 'نام خانوادگی',
                                    hintStyle: TextStyle(
                                        fontFamily: Preferences.fontName)),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'نام خانوادگی را وارد کنید';
                                  }
                                  return null;
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 25.0),
                                    child: RaisedButton(
                                      onPressed: () {
                                        // Validate returns true if the form is valid, or false
                                        // otherwise.
                                        if (_formKey.currentState.validate()) {
                                          // If the form is valid, display a Snackbar.
                                          Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                  content:
                                                      Text('Processing Data')));
                                          accountApi
                                          
                                              .updateUserClimes(
                                                  name: nameController.text,
                                                  family: familyController.text,
                                                  imageUser:
                                                      widget.user.imageUser)
                                              .then((response) {                                         
                                            userBloc.updateUser();
                                          });
                                        }
                                      },
                                      child: Text(
                                        'ثبت تغییرات',
                                        style: TextStyle(
                                            fontFamily: Preferences.fontName),
                                      ),
                                      textColor: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ))),
                  )
                ],
              )),
    );
  }

  Widget _buildHeader(User user) {
    return Row(
      children: <Widget>[
        Text(
          '${user.userName}',
        ),
        CircleAvatar(
          backgroundImage: NetworkImage(user.imageUser),
          radius: 25,
        )
      ],
    );
  }
}
