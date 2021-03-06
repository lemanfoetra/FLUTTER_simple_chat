import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  final _store = Firestore.instance;
  bool isLoading = false;

  Future<void> _submitAuth(
    String email,
    String username,
    String password,
    bool isLogin,
    File imageFile,
    BuildContext ctx,
  ) async {
    AuthResult _authResult;
    setState(() {
      isLoading = true;
    });
    try {
      if (isLogin) {
        // LOGIN
        _authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        // REGISTER
        _authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // UPLOAD image users
        final ref = FirebaseStorage.instance
            .ref()
            .child('users_image')
            .child("${_authResult.user.uid}.jpg");
        await ref.putFile(imageFile).onComplete;

        // GET url file setelah di upload
        final urlImage = await ref.getDownloadURL();

        // SIMPAN DATA KE FIREBASE CLOUD
        await _store
            .collection('users')
            .document(_authResult.user.uid)
            .setData({
          "username": username,
          "email": email,
          "image_url": urlImage,
        });
      }
    } on PlatformException catch (error) {
      var message = "Error, mohon cek keabsahan data kamu";
      if (error.message != null) {
        message = error.message;
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print("ERROR : $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: AuthForm(
            submitFn: _submitAuth,
            isLoading: isLoading,
          ),
        ),
      ),
    );
  }
}
