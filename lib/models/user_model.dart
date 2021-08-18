class UserModel {
  late String fullName;
  late String email;
  late String phone;
  late String birthday;
  late String country;
  late String gender;
  late String bio;
  late String image;
  late String cover;
  late String uId;

  UserModel({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.birthday,
    required this.country,
    required this.gender,
    required this.bio,
    required this.image,
    required this.cover,
    required this.uId,
  });

  UserModel.fromJson(Map<String, dynamic> json)
  {
    fullName = json['fullName'];
    email = json['email'];
    phone = json['phone'];
    birthday = json['birthday'];
    country = json['country'];
    gender = json['gender'];
    bio = json['bio'];
    image = json['image'];
    cover = json['cover'];
    uId = json['uId'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'fullName':fullName,
      'email':email,
      'phone':phone,
      'birthday':birthday,
      'country':country,
      'gender':gender,
      'bio':bio,
      'image':image,
      'cover':cover,
      'uId':uId,
    };
  }
}