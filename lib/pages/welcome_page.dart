import 'package:blog_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/sign_button.dart';
import '../utils/item_fader.dart';

class WelcomePage extends StatelessWidget {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ItemFader(
                  delay: 0.1,
                  child: Text(
                    'Blog App',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ItemFader(
                  delay: 0.3,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'Great stories for great people with blog app.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ItemFader(
                  delay: 0.5,
                  child: SignButton(
                    title: 'Sign Up With Google',
                    iconColor: Colors.redAccent,
                    icon: FontAwesomeIcons.google,
                    onClick: () {},
                  ),
                ),
                SizedBox(height: 20),
                ItemFader(
                  delay: 0.7,
                  child: SignButton(
                    title: 'Sign Up With Facebook',
                    iconColor: Colors.blueAccent,
                    icon: FontAwesomeIcons.facebookF,
                    onClick: () {},
                  ),
                ),
                SizedBox(height: 20),
                ItemFader(
                  delay: 0.9,
                  child: SignButton(
                    title: 'Sign Up With Mail',
                    iconColor: Colors.grey,
                    icon: FontAwesomeIcons.envelope,
                    onClick: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, signUpPage);
                    },
                  ),
                ),
                SizedBox(height: 40),
                ItemFader(
                  delay: 1.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Already have an account ? '),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, signInPage);
                        },
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
