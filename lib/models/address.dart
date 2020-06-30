/// References
/// https://flutter.dev/docs/development/data-and-backend/json#running-the-code-generation-utility
/// https://jsonplaceholder.typicode.com
/// https://jsonplaceholder.typicode.com/users

import 'package:json_annotation/json_annotation.dart';

import 'package:investigation/models/geo_location.dart';

part 'address.g.dart';

/// Address
@JsonSerializable()
class Address {

  /// ctr
  Address({this.street, this.suite, this.city, this.zipcode, this.geoLocation});

  /// properties

  @JsonKey(name: 'street')
  String street;

  @JsonKey(name: 'suite')
  String suite;  

  @JsonKey(name: 'city')
  String city;    

  @JsonKey(name: 'zipcode')
  String zipcode;      

  GeoLocation geoLocation;

  /// methods
  
  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

