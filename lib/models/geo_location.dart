/// References
/// https://flutter.dev/docs/development/data-and-backend/json#running-the-code-generation-utility
/// https://jsonplaceholder.typicode.com
/// https://jsonplaceholder.typicode.com/users

import 'package:json_annotation/json_annotation.dart';

part 'geo_location.g.dart';

/// GeoLocation
@JsonSerializable()
class GeoLocation {

  /// ctr
  GeoLocation({this.latitude, this.longitute});

  /// properties

  @JsonKey(name: 'lat')
  String latitude;

  @JsonKey(name: 'lng')
  String longitute;

  /// methods
  
  factory GeoLocation.fromJson(Map<String, dynamic> json) => _$GeoLocationFromJson(json);

  Map<String, dynamic> toJson() => _$GeoLocationToJson(this);
}