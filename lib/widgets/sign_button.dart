import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignButton extends StatelessWidget {
  final title, iconColor, icon, onClick;
  const SignButton({
    @required this.title,
    this.iconColor,
    this.icon,
    @required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onClick,
      color: Colors.white,
      child: ListTile(
        leading: FaIcon(
          icon,
          color: iconColor,
          size: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
