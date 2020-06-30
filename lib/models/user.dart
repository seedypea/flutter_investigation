/// References
/// https://flutter.dev/docs/development/data-and-backend/json#running-the-code-generation-utility
/// https://jsonplaceholder.typicode.com
/// https://jsonplaceholder.typicode.com/users

import 'package:json_annotation/json_annotation.dart';

import 'package:investigation/models/address.dart';

part 'user.g.dart';

@JsonSerializable()
class User {

  /// ctr
  User({this.id, this.name, this.username, this.email, this.address, this.phone, this.website});

  /// properties

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'username')
  String username;  

  @JsonKey(name: 'email')
  String email;    

  Address address;

  @JsonKey(name: 'phone')
  String phone;    

  @JsonKey(name: 'website')
  String website;      

  /// methods
  
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}

