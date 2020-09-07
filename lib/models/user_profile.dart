class UserProfile {
  String _id, _name, _image;

  UserProfile(this._id, this._name, this._image);

  String get id => this._id;
  String get name => this._name;
  String get image => this._image;

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      json['_id'],
      json['name'],
      json['image'],
    );
  }

  toJson() {
    return {
      '_id': this._id,
      'name': this._name,
      'image': this._image,
    };
  }
}
