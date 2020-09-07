import 'package:blog_app/pages/article_details.dart';
import 'package:blog_app/utils/constants.dart';
import 'package:blog_app/widgets/post_user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/post.dart';
import '../models/user_profile.dart';
import '../services/services.dart';

class ArticlesPage extends StatefulWidget {
  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  List<Post> allPosts = [];
  UserProfile currentUser;
  String token;

  final Services _services = Services();
  final _storage = FlutterSecureStorage();

  Future getAllPosts() async {
    var data = await _services.get('/api/post/showAll');

    List<Post> posts = [];

    for (int i = 0; i < data['response'].length; i++) {
      Post post = Post.fromJson(data['response'][i]);
      posts.add(post);
    }

    setState(() => allPosts = posts);
  }

  checkToken() async {
    token = await _storage.read(key: 'token');
    if (token != null) {
      getAllPosts();
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: allPosts.length == 0
          ? Container(
              child: Center(
                child: Text('Loading ...'),
              ),
            )
          : ListView.builder(
              itemCount: allPosts.length,
              itemBuilder: (context, index) {
                Post post = allPosts[index];
                return GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ArticleDetails(post.id),
                    ),
                  ),
                  child: Card(
                    margin: index != allPosts.length - 1
                        ? EdgeInsets.all(10)
                        : EdgeInsets.only(
                            top: 10, left: 10, right: 10, bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        PostUserInfo(post),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            post.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Image(
                          image: NetworkImage(
                            '$SERVER_URL/${post.image.replaceAll('\\', '//')}',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
/*
Container(
                  height: 300,
                  width: double.infinity,
                  margin: index == allPosts.length - 1
                      ? EdgeInsets.only(bottom: 30, left: 10, right: 10)
                      : EdgeInsets.all(10),
                  child: Card(
                    elevation: 3,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          PostUserInfo(post),
                          SizedBox(height: 10),
                          Text(post.content),
                          SizedBox(height: 10),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    '$SERVER_URL/${post.image.replaceAll('\\', '//')}',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
 */
