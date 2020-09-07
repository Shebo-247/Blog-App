import 'package:blog_app/services/services.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'package:toast/toast.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isSecure = true;

  final _globalKey = GlobalKey<FormState>();

  final Services _services = Services();
  final _storage = FlutterSecureStorage();

  TextEditingController _emailController,
      _usernameController,
      _passwordController;

  String userErrorText, emailErrorText;
  bool _userValidated = false;
  bool _emailValidated = false;
  bool _circular = false;

  _signUp() async {
    // check if username is taken
    setState(() => _circular = true);
    await checkUsernameAvailability(_usernameController.text);
    await checkEmailAvailability(_emailController.text);

    if (_globalKey.currentState.validate() &&
        _userValidated &&
        _emailValidated) {
      print('user and email validated');
      Map<String, String> bodyData = {
        "username": _usernameController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
      };
      await _services.post('/api/register', bodyData);
      signIn();
      //setState(() => _circular = false);
      Toast.show(
        "User created Successfully",
        context,
        duration: Toast.LENGTH_LONG,
      );
    } else {
      setState(() => _circular = false);
    }
  }

  checkUsernameAvailability(username) async {
    if (username.length != 0) {
      var response = await _services.get('/api/checkUsername/$username');
      if (response['status']) {
        setState(() {
          userErrorText = 'Username is taken';
          _userValidated = false;
        });
      } else {
        setState(() {
          _userValidated = true;
        });
      }
    } else {
      setState(() {
        _circular = false;
        _userValidated = false;
        userErrorText = "Username can't be empty";
      });
    }
  }

  checkEmailAvailability(email) async {
    if (email.length != 0) {
      var response = await _services.get('/api/checkEmail/$email');
      if (response['status']) {
        setState(() {
          emailErrorText = 'Email is already used';
          _emailValidated = false;
        });
      } else {
        setState(() {
          _emailValidated = true;
        });
      }
    } else {
      setState(() {
        _circular = false;
        _emailValidated = false;
        emailErrorText = "Email must provided";
      });
    }
  }

  signIn() async {
    Map<String, String> bodyData = {
      "username": _usernameController.text,
      "password": _passwordController.text,
    };

    var response = await _services.post('/api/login', bodyData);
    if (response.statusCode == 200) {
      var output = jsonDecode(response.body);
      await _storage.write(key: "token", value: output['token']);
      await _storage.write(key: 'username', value: _usernameController.text);
      setState(() => _circular = false);
      Navigator.pop(context);
      Navigator.pushNamed(context, homePage);
    } else {
      setState(() => _circular = false);
      Toast.show(
        'Network Error',
        context,
        duration: Toast.LENGTH_LONG,
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'Blog App',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 40),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          validator: (value) {
                            if (!value.contains('@')) return 'invalid mail';
                            return null;
                          },
                          decoration: InputDecoration(
                            errorText: _emailValidated ? null : emailErrorText,
                            labelText: 'Email Address',
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
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            errorText: _userValidated ? null : userErrorText,
                            labelText: 'Username',
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
                        SizedBox(height: 20),
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
                        SizedBox(height: 30),
                        RaisedButton(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          color: Colors.green,
                          onPressed: _signUp,
                          child: Text(
                            'Sign Up'.toUpperCase(),
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
                            'Back to sign in',
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
