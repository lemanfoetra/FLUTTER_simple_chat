import 'package:flutter/material.dart';
import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatelessWidget {
  void _submitAuth(
    String email,
    String username,
    String password,
    bool isLogin,
  ) {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: AuthForm(_submitAuth),
        ),
      ),
    );
  }
}
