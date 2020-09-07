import 'package:blog_app/models/post.dart';
import 'package:blog_app/models/user_profile.dart';
import 'package:blog_app/services/services.dart';
import '../utils/constants.dart';
import 'package:flutter/material.dart';

class PostUserInfo extends StatelessWidget {
  final Post post;

  PostUserInfo(this.post);

  final Services _services = Services();

  Future getUserInfo(String userID) async {
    var data = await _services.get('/api/profile/show/$userID');
    UserProfile user = UserProfile.fromJson(data['response']);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserInfo(post.author),
      builder: (context, snapshot) {
        if (snapshot.data == null) return Container();

        UserProfile user = snapshot.data;
        return Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 30,
                child: Image(
                  image: NetworkImage(
                      '$SERVER_URL/${user.image.replaceAll('\\', '//')}'),
                ),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(post.time.substring(0, 10)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
