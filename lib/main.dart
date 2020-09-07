import './routes/page_router.dart';
import './utils/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      onGenerateRoute: PageRouter.allRoutes,
      initialRoute: homePage,
    );
  }
}
