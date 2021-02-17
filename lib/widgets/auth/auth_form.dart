import 'package:flutter/material.dart';
import 'package:simple_chat/widgets/pickers/user_image_picker.dart';
import 'dart:io';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String username,
    String password,
    bool isLogin,
    File _image,
    BuildContext ctx,
  ) submitFn;

  AuthForm({this.submitFn, this.isLoading});

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isLogin = true;
  String _email = "";
  String _username = "";
  String _password = "";
  File _imageFile;

  void _pickedImage(File imageFile) {
    _imageFile = imageFile;
  }

  void _onSubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    // JIKA REGISTER CEK APAKAH USERS TELAH PICK IMAGE?
    if (_imageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Mohon Upload Image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      // PARSING DATA TO AUTH SCREEN
      widget.submitFn(
        _email.trim(),
        _username.trim(),
        _password.trim(),
        _isLogin,
        _imageFile,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (!_isLogin) UserImagePicker(_pickedImage),
                TextFormField(
                  key: ValueKey('email'),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Email"),
                  validator: (value) {
                    if (value.isEmpty || !value.contains("@")) {
                      return "Mohon masukan email yang valid";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value;
                  },
                ),
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    decoration: InputDecoration(labelText: "Username"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Username harus diisi";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _username = value;
                    },
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty || value.length < 8) {
                      return "Panjang password minimal 8 karakter";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value;
                  },
                ),
                SizedBox(height: 15),
                widget.isLoading
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      )
                    : RaisedButton(
                        child: Text(
                          _isLogin ? 'Login' : 'Register',
                        ),
                        onPressed: () {
                          _onSubmit();
                        },
                      ),
                !widget.isLoading
                    ? FlatButton(
                        child: Text(
                          _isLogin
                              ? 'Create a new account'
                              : 'I have a account',
                        ),
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                      )
                    : Center(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
