import 'dart:convert';

import 'package:stdio_week_6/services/cloud_firestore/user_firestore.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    required this.name,
    required this.avatar,
    required this.follow,
  });

  String id;
  String name;
  String avatar;
  List<String> follow = [];

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        follow: List<String>.from(json["follow"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "follow": follow,
      };
}

User currenUser = User(
  id: 'u1',
  name: '.....',
  avatar:
      'https://w7.pngwing.com/pngs/516/431/png-transparent-female-profile-avatar-illustration-computer-icons-female-user-profile-female-girl-wife-woman-icon-miscellaneous-logo-monochrome.png',
  follow: [],
);

void resetUser() async {
  currenUser = await UserFirestore().getUser(currenUser: true, uid: '');
}
