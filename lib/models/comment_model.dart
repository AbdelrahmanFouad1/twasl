class CommentModel {
  late String name;
  late String uId;
  late String image;
  late String dateTime;
  late String text;

  CommentModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.dateTime,
    required this.text,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name':name,
      'uId':uId,
      'image':image,
      'dateTime':dateTime,
      'text':text,
    };
  }
}
