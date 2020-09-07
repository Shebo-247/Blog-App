import '../pages/articles_page.dart';
import '../pages/add_article_page.dart';
import '../pages/profile_page.dart';
import '../pages/home_page.dart';
import '../pages/signin_page.dart';
import '../pages/signup_page.dart';
import '../pages/welcome_page.dart';
import '../utils/constants.dart';
import 'package:flutter/material.dart';

class PageRouter {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case welcomePage:
        return MaterialPageRoute(builder: (_) => WelcomePage());
      case signUpPage:
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case signInPage:
        return MaterialPageRoute(builder: (_) => SignInPage());
      case homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case articlesPage:
        return MaterialPageRoute(builder: (_) => ArticlesPage());
      case profilePage:
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case addArticlePage:
        return MaterialPageRoute(builder: (_) => AddArticlePage());
    }
  }
}
