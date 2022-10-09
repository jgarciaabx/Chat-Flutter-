import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? id;
  String? email;
  String? name;
  String? lastname;
  String? phone;
  String? password;
  String? sessionToken;
  String? image;
  String? isAvailable;

  User({
    this.id,
    this.email,
    this.name,
    this.lastname,
    this.phone,
    this.image,
    this.password,
    this.isAvailable,
    this.sessionToken,
  });

  /*
  TRANSFORMAR JSON DE UN MODELO USUARIO 
  */
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        lastname: json["lastname"],
        phone: json["phone"],
        image: json["image"],
        password: json["password"],
        isAvailable: json["is_available"],
        sessionToken: json["session_token"],
      );

  static List<User> fromJsonList(List<dynamic> jsonList) {
    List<User> toList = [];
    jsonList.forEach((item) {
      User user = User.fromJson(item);
      toList.add(user);
    });

    return toList;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "lastname": lastname,
        "phone": phone,
        "image": image,
        "password": password,
        "is_available": isAvailable,
        "session_token": sessionToken,
      };
}
