import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:toast/toast.dart';

import '../services/services.dart';
import '../utils/constants.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isSecure = true;

  final _globalKey = GlobalKey<FormState>();
  TextEditingController _usernameController, _passwordController;

  Services _services = Services();

  String _userErrorText, _passwordErrorText;
  bool _circular = false;

  final _storage = FlutterSecureStorage();

  _signIn() async {
    setState(() => _circular = true);

    if (_globalKey.currentState.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;
      Map<String, String> bodyData = {
        "username": username,
        "password": password
      };

      var response = await _services.post('/api/login', bodyData);
      var output = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          _userErrorText = null;
          _passwordErrorText = null;
          _circular = false;
        });

        await _storage.write(key: 'token', value: output['token']);
        await _storage.write(key: 'username', value: username);
        Navigator.pop(context);
        Navigator.pushNamed(context, homePage);
      } else if (response.statusCode == 500) {
        setState(() {
          _userErrorText = "User not exist";
          _circular = false;
        });
      } else if (response.statusCode == 403) {
        print(output['message']);
        setState(() {
          _passwordErrorText = "Password incorrect";
          _circular = false;
        });
      }
    } else {
      setState(() {
        _circular = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: kLinearGradient,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _globalKey,
              child: _circular
                  ? Center(
                      child: Container(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Blog App',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 50),
                        TextFormField(
                          controller: _usernameController,
                          validator: (value) {
                            if (value.isEmpty) return "Username can't be empty";
                            return null;
                          },
                          decoration: InputDecoration(
                            errorText: _userErrorText,
                            labelText: 'Username or Emial',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          controller: _passwordController,
                          validator: (value) {
                            if (value.isEmpty) return "Password can't be empty";
                            if (value.length < 8)
                              return 'Password must be more than 8 characters';
                            return null;
                          },
                          obscureText: isSecure,
                          decoration: InputDecoration(
                            errorText: _passwordErrorText,
                            suffixIcon: IconButton(
                              icon: isSecure
                                  ? Icon(Icons.visibility_off,
                                      color: Colors.black)
                                  : Icon(Icons.visibility, color: Colors.black),
                              onPressed: () =>
                                  setState(() => isSecure = !isSecure),
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        RaisedButton(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          color: Colors.green,
                          onPressed: _signIn,
                          child: Text(
                            'Sign In'.toUpperCase(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            'Back to previous page',
                            style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
