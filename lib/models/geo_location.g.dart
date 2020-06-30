// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoLocation _$GeoLocationFromJson(Map<String, dynamic> json) {
  return GeoLocation(
    latitude: json['lat'] as String,
    longitute: json['lng'] as String,
  );
}

Map<String, dynamic> _$GeoLocationToJson(GeoLocation instance) =>
    <String, dynamic>{
      'lat': instance.latitude,
      'lng': instance.longitute,
    };
