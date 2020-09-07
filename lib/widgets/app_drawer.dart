import 'package:blog_app/models/user_profile.dart';
import 'package:blog_app/services/services.dart';
import 'package:blog_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final _storage = FlutterSecureStorage();

  final _services = Services();

  UserProfile currentUser;

  getUserInfo() async {
    String username = await _storage.read(key: 'username');
    var data = await _services.get('/api/$username');
    var userInfo =
        await _services.get('/api/profile/show/${data['user']['_id']}');

    UserProfile user = UserProfile.fromJson(userInfo['response']);
    setState(() => currentUser = user);
  }

  _logout() async {
    await _storage.delete(key: 'token');
    Navigator.pop(context);
    Navigator.pushNamed(context, welcomePage);
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black12,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: appTheme.primaryColor,
                    radius: 50,
                    child: Image(
                      image: currentUser != null
                          ? NetworkImage(
                              '$SERVER_URL/${currentUser.image.replaceAll('\\', '//')}',
                            )
                          : AssetImage('assets/images/user.png'),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    currentUser != null ? '${currentUser.name}' : '',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: InkWell(
                onTap: _logout,
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
