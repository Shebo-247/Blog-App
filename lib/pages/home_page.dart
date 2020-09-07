import 'package:blog_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../utils/constants.dart';
import '../pages/articles_page.dart';
import '../pages/profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  List<Widget> bodyWidgets = [
    ArticlesPage(),
    ProfilePage(),
  ];

  final _storage = FlutterSecureStorage();
  String currentUser;

  checkUserLoggedIn() async {
    String token = await _storage.read(key: 'token');
    String user = await _storage.read(key: 'username');

    setState(() => currentUser = user);

    if (token == null) {
      Navigator.pop(context);
      Navigator.pushNamed(context, welcomePage);
    }
  }

  @override
  void initState() {
    super.initState();

    checkUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: currentPage == 0 ? Text('Home Page') : Text('Profile Page'),
      ),
      floatingActionButton: Container(
        width: 130,
        child: MaterialButton(
          onPressed: () {},
          height: 55,
          color: appTheme.primaryColor,
          elevation: 1,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 4,
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add,
                color: Colors.white,
                size: 25,
              ),
              SizedBox(width: 10),
              Text(
                'Post',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: AppDrawer(),
      bottomNavigationBar: BottomAppBar(
        color: appTheme.primaryColor,
        child: Container(
          height: 65,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AnimatedContainer(
                duration: Duration(milliseconds: 250),
                curve: Curves.bounceInOut,
                child: IconButton(
                  onPressed: () => setState(() => currentPage = 0),
                  icon: Icon(
                    Icons.home,
                    size: currentPage == 0 ? 35 : 30,
                    color: currentPage == 0 ? Colors.white : Colors.grey,
                  ),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.bounceInOut,
                child: IconButton(
                  onPressed: () => setState(() => currentPage = 1),
                  icon: Icon(
                    Icons.person,
                    size: currentPage == 1 ? 35 : 30,
                    color: currentPage == 1 ? Colors.white : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: bodyWidgets[currentPage],
    );
  }
}
