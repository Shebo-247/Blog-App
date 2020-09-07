import '../utils/constants.dart';
import '../widgets/post_user_info.dart';
import '../models/post.dart';
import '../services/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';

class ArticleDetails extends StatefulWidget {
  final String postID;

  ArticleDetails(this.postID);

  @override
  _ArticleDetailsState createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {
  final Services _services = Services();

  Post currentPost;

  getPostDetails() async {
    var data = await _services.get('/api/post/show/${widget.postID}');
    Post post = Post.fromJson(data['response']);

    setState(() => currentPost = post);
  }

  parsePostContent(content) {
    var document = parser.parse(content);
    print(document.children.first.innerHtml);
    return document.body.innerHtml;
  }

  @override
  void initState() {
    super.initState();
    getPostDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
      ),
      body: currentPost != null
          ? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    PostUserInfo(currentPost),
                    SizedBox(height: 15),
                    Text(
                      currentPost.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Html(data: currentPost.content),
                    Image(
                      image: NetworkImage(
                        '$SERVER_URL/${currentPost.image.replaceAll('\\', '//')}',
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(),
    );
  }
}
