/// References
/// https://flutter.dev/docs/development/data-and-backend/json#running-the-code-generation-utility
/// https://jsonplaceholder.typicode.com
/// https://jsonplaceholder.typicode.com/users

import 'package:json_annotation/json_annotation.dart';

import 'package:investigation/models/user.dart';

@JsonSerializable()
class Users {

  /// ctr
  Users({this.users});

  /// properties

  List<User> users;

  /// methods

  factory Users.fromJson(List<dynamic> json) {

    List<User> users = new List<User>();

    users = json.map((i)=>User.fromJson(i)).toList();

    return new Users(users: users);

  }

}