class Post {
  String _id, _title, _content, _author, _image, _time;

  Post(
    this._id,
    this._title,
    this._content,
    this._author,
    this._image,
    this._time,
  );

  String get id => this._id;
  String get title => this._title;
  String get content => this._content;
  String get author => this._author;
  String get image => this._image;
  String get time => this._time;

  factory Post.fromJson(json) {
    return Post(
      json['_id'],
      json['title'],
      json['content'],
      json['author'],
      json['image'],
      json['createdAt'],
    );
  }
}
