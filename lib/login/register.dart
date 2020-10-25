import 'dart:convert';

import 'package:klinkmediatama/api.dart';
import 'package:klinkmediatama/src/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nama = new TextEditingController();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();

  int value = 0;
  String msg = '';

  final formKey = GlobalKey<FormState>();

  bool _secureText = true;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  void showToast(msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.grey,
        textColor: Colors.white);
  }

  @override
  Widget _header() {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 1,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/back2.png"), fit: BoxFit.fill)),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 2,
            ),
            _nama(),
            _username(),
            _password(),
            _buttonSubmit(),
            _or(),
            _register()
          ],
        )
      ],
    );
  }

  Widget _username() {
    return Container(
      padding: EdgeInsets.only(top: 25, left: 25, right: 25),
      decoration: BoxDecoration(),
      child: TextFormField(
        controller: username,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Username',
          icon: Icon(Icons.person),
          filled: false,
          alignLabelWithHint: false,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
      ),
    );
  }

  Widget _nama() {
    return Container(
      padding: EdgeInsets.only(left: 25, right: 25),
      decoration: BoxDecoration(),
      child: TextFormField(
        controller: nama,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Nama',
          icon: Icon(Icons.person_outline),
          filled: false,
          alignLabelWithHint: false,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
      ),
    );
  }

  Widget _password() {
    return Container(
      padding: EdgeInsets.only(top: 25, left: 25, right: 25),
      decoration: BoxDecoration(),
      child: TextFormField(
        controller: password,
        autofocus: false,
        obscureText: _secureText,
        decoration: InputDecoration(
          hintText: 'Password',
          icon: Icon(Icons.vpn_key),
          suffixIcon: IconButton(
              icon: Icon(_secureText ? Icons.visibility_off : Icons.visibility),
              onPressed: showHide),
          filled: false,
          alignLabelWithHint: false,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
      ),
    );
  }

  Widget _buttonSubmit() {
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: Padding(
        padding: EdgeInsets.only(top: 8),
        child: MaterialButton(
          minWidth: 350,
          height: 50,
          color: Colors.blue,
          onPressed: () {
            if (nama.text == '') {
              showToast("Periksa Kembali Nama anda");
            } else {
              if (username.text == '') {
                showToast("Periksa Kembali Username anda");
              } else {
                if (password.text == '') {
                  showToast("Periksa Kembali Password anda");
                } else {
                  // _login();
                }
              }
            }
          },
          child: Text("Log In", style: TextStyle(color: Colors.white)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: Colors.blue)),
        ),
      ),
    );
  }

  Widget _or() {
    return Container(
      margin: EdgeInsets.only(top: 25, left: 10, right: 10),
      child: Row(
        children: <Widget>[
          Flexible(flex: 2, child: Divider()),
          Text(
            "OR",
            style: TextStyle(),
          ),
          Flexible(flex: 2, child: Divider())
        ],
      ),
    );
  }

  Widget _register() {
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: Padding(
          padding: EdgeInsets.only(top: 8),
          child: MaterialButton(
            minWidth: 350,
            height: 50,
            onPressed: () {
              // method
            },
            child: Text(
              "Register",
              style: TextStyle(color: Colors.blue),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: Colors.blue)),
          )),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        key: formKey,
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate([
            _header(),
          ]))
        ],
      ),
    );
  }
}
