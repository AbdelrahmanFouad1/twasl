class PostModel {
  late String name;
  late String uId;
  late String postId;
  late String image;
  late String postImage;
  late String dateTime;
  late String body;
  late String tags;

  PostModel({
    required this.name,
    required this.uId,
    required this.postId,
    required this.image,
    required this.postImage,
    required this.dateTime,
    required this.body,
    required this.tags,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    postId = json['postId'];
    image = json['image'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
    body = json['body'];
    tags = json['tags'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'postId': postId,
      'image': image,
      'dateTime': dateTime,
      'body': body,
      'postImage': postImage,
      'tags': tags,
    };
  }
}
